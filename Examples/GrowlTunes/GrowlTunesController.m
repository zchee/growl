//
//  GrowlTunesController.m
//  GrowlTunes
//
//  Created by Nelson Elhage on Mon Jun 21 2004.
//  Copyright (c) 2004 Nelson Elhage. All rights reserved.
//

#import "GrowlTunesController.h"
#import "GrowlDefines.h"
#import <GrowlAppBridge/GrowlApplicationBridge.h>
#import "NSGrowlAdditions.h"

#define ONLINE_HELP_URL		    @"http://growl.info/documentation/growltunes.php"

// sticking this here for a bit of version checking while setting the menu icon
#ifndef NSAppKitVersionNumber10_2
#define NSAppKitVersionNumber10_2 663
#endif

@interface GrowlTunesController (PRIVATE)
- (NSAppleScript *)appleScriptNamed:(NSString *)name;
@end

static NSString *appName = @"GrowlTunes";
static NSString *iTunesAppName = @"iTunes.app";
static NSString *iTunesBundleID = @"com.apple.itunes";

static NSString *pollIntervalKey = @"Poll interval";

//status item menu item tags.
enum {
	onlineHelp,
	quitGrowlTunesTag,
	launchQuitiTunesTag,
	quitBothTag,
	togglePollingTag
};

@interface NSObject(GrowlTunesDummyPlugin)

//shuts up a warning.
- (NSImage *)artworkForTitle:(NSString *)track
					byArtist:(NSString *)artist
					 onAlbum:(NSString *)album;

@end

@implementation GrowlTunesController

- (id)init
{
	self = [super init];

	if(self) {
		[GrowlAppBridge launchGrowlIfInstalledNotifyingTarget:self selector:@selector(registerGrowl:) context:NULL];
		self->state = itUNKNOWN;

		[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithDouble:DEFAULT_POLL_INTERVAL], pollIntervalKey,
			nil]];

		self->plugins = [[self loadPlugins] retain];
	}

	return self;
}

- (void)registerGrowl:(void *)context
{
	NSArray			* allNotes = [NSArray arrayWithObjects: 
		ITUNES_TRACK_CHANGED, 
//		ITUNES_PAUSED, 
//		ITUNES_STOPPED,
		ITUNES_PLAYING, 
		nil];
	NSImage			* iTunesIcon = [[NSWorkspace sharedWorkspace] iconForApplication:iTunesAppName];
	NSDictionary	* regDict = [NSDictionary dictionaryWithObjectsAndKeys:
		appName, GROWL_APP_NAME,
		[iTunesIcon TIFFRepresentation], GROWL_APP_ICON,
		allNotes, GROWL_NOTIFICATIONS_ALL,
		allNotes, GROWL_NOTIFICATIONS_DEFAULT,
		nil];
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:GROWL_APP_REGISTRATION object:nil userInfo:regDict];
}

- (void)applicationWillFinishLaunching: (NSNotification *)notification
{
	pollScript       = [self appleScriptNamed:@"polliTunes"];
	getTrackScript   = [self appleScriptNamed:@"getTrack"];
	getArtistScript  = [self appleScriptNamed:@"getArtist"];
	getArtworkScript = [self appleScriptNamed:@"getArtwork"];
	getAlbumScript   = [self appleScriptNamed:@"getAlbum"];
	quitiTunesScript = [self appleScriptNamed:@"quitiTunes"];

	pollInterval = [[NSUserDefaults standardUserDefaults] floatForKey:pollIntervalKey];

	if([self iTunesIsRunning]) {
		[self startTimer];
	}

	NSNotificationCenter *workspaceCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
	[workspaceCenter addObserver:self
						selector:@selector(handleAppLaunch:)
							name:NSWorkspaceDidLaunchApplicationNotification
						  object:nil];
	[workspaceCenter addObserver:self
						selector:@selector(handleAppQuit:)
							name:NSWorkspaceDidTerminateApplicationNotification
						  object:nil];

	[self createStatusItem];
}

- (void)dealloc
{
	[[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
	[self stopTimer];
	
	[pollScript release];
	[getTrackScript release];
	[getArtistScript release];
	[getArtworkScript release];
	[getAlbumScript release];

	[plugins release];

	[self tearDownStatusItem];

	[super dealloc];
}

#pragma mark Poll timer

- (void)poll: (NSTimer *)timer
{
	NSDictionary			* error = nil;
	NSAppleEventDescriptor  * retVal;
	NSString				* playerState;
	iTunesState				newState;
	int						newTrackID = -1;
	
	retVal = [pollScript executeAndReturnError:&error];
	
	playerState = [retVal stringValue];
	
	if([playerState isEqualToString:@"quitting"]){
//		[self stopTimer];
//		return;
		NSLog(@"Poll script returned error!");
	}else if([playerState isEqualToString:@"paused"]) {
		newState = itPAUSED;
	} else if([playerState isEqualToString:@"stopped"]) {
		newState = itSTOPPED;
	} else {
		newState = itPLAYING;
		newTrackID = [retVal int32Value];
	}
	
	if(state == itUNKNOWN) {
		state = newState;
		trackID = newTrackID;
		return;
	}
	
	if(state != newState || trackID != newTrackID) {
		if(newState == itPLAYING) {
			if(state == itPLAYING || state == itSTOPPED) {
				NSString		* track = nil;
				NSString		* artist = nil;
				NSString		* album = nil;
				NSImage			* artwork = nil;
				NSDictionary	* noteDict;
				
				retVal = [getTrackScript executeAndReturnError:&error];
				if(retVal)
					track = [retVal stringValue];
				
				retVal = [getArtistScript executeAndReturnError:&error];
				if(retVal)
					artist = [retVal stringValue];
				
				retVal = [getAlbumScript executeAndReturnError:&error];
				if(retVal)
					album = [retVal stringValue];
				
				retVal = [getArtworkScript executeAndReturnError:&error];
				const OSType type = [retVal typeCodeValue];
				if(type && (type != 'null'))
					artwork = [[[NSImage alloc] initWithData:[retVal data]] autorelease];
				else {
					NSEnumerator *pluginEnum = [plugins objectEnumerator];
					id plugin;
					while( (artwork == nil) && (plugin = [pluginEnum nextObject]) ) {
						artwork = [plugin artworkForTitle:track
												 byArtist:artist
												  onAlbum:album];
					}
					if(artwork == nil) {
						if (error != nil) {
							NSLog(@"Error getting artwork: %@", [error objectForKey:NSAppleScriptErrorMessage]);
							if([plugins count])
								NSLog(@"No plug-ins found anything either, or you wouldn't have this message.");
						}
						// Use the iTunes icon instead
						artwork = [[NSWorkspace sharedWorkspace] iconForApplication:@"iTunes"];
						[artwork setSize:NSMakeSize(128.,128.)];
					}
				}
				
				noteDict = [NSDictionary dictionaryWithObjectsAndKeys:
					( state == itPLAYING ? ITUNES_TRACK_CHANGED : ITUNES_PLAYING ), GROWL_NOTIFICATION_NAME,
					appName, GROWL_APP_NAME,
					track, GROWL_NOTIFICATION_TITLE,
					[NSString stringWithFormat:@"%@\n%@",artist,album], GROWL_NOTIFICATION_DESCRIPTION,
								 artwork?[artwork TIFFRepresentation]:nil, GROWL_NOTIFICATION_ICON,
					nil];
				[[NSDistributedNotificationCenter defaultCenter] postNotificationName:GROWL_NOTIFICATION
																			   object:nil userInfo:noteDict];
			}
		}
		state = newState;
		trackID = newTrackID;
	}
}

- (void)startTimer {
	if(pollTimer == nil) {
		pollTimer = [[NSTimer scheduledTimerWithTimeInterval:pollInterval 
													  target:self
													selector:@selector(poll:)
													userInfo:nil
													 repeats:YES] retain];
		NSLog(@"Polling started");
		[self poll:nil];
	}
}

- (void)stopTimer {
	if(pollTimer){
		[pollTimer invalidate];
		[pollTimer release];
		pollTimer = nil;
		NSLog(@"Polling stopped");
	}
}

#pragma mark Status item

- (void)createStatusItem {
	if(!statusItem) {
		NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
		statusItem = [[statusBar statusItemWithLength:NSSquareStatusItemLength] retain];
		if(statusItem) {
			[statusItem setMenu:[self statusItemMenu]];
            
			[statusItem setHighlightMode:YES];
			[statusItem setImage:[NSImage imageNamed:@"growlTunes.tif"]];
            if(floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_2)  {
              [statusItem setAlternateImage:[NSImage imageNamed:@"growlTunes-selected.tif"]];
            }
		}
	}
}

- (void)tearDownStatusItem {
	if(statusItem) {
		[statusItem release];
		statusItem = nil;
	}
}

- (NSMenu *)statusItemMenu {
	NSMenu *menu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:@"GrowlTunes"];
	if(menu) {
		id <NSMenuItem> item;
		NSString *empty = @""; //used for the key equivalent of all the menu items.

		item = [menu addItemWithTitle:@"Online Help" action:@selector(onlineHelp:) keyEquivalent:empty];
		[item setTarget:self];
		[item setTag:onlineHelp];		
		item = [NSMenuItem separatorItem];
		[menu addItem:item];
		item = [menu addItemWithTitle:@"Quit GrowlTunes" action:@selector(quitGrowlTunes:) keyEquivalent:empty];
		[item setTarget:self];
		[item setTag:quitGrowlTunesTag];
		item = [menu addItemWithTitle:@"Launch iTunes" action:@selector(launchQuitiTunes:) keyEquivalent:empty];
		[item setTarget:self];
		[item setTag:launchQuitiTunesTag];
		item = [menu addItemWithTitle:@"Quit Both" action:@selector(quitBoth:) keyEquivalent:empty];
		[item setTarget:self];
		[item setTag:quitBothTag];
		item = [NSMenuItem separatorItem];
		[menu addItem:item];
		item = [menu addItemWithTitle:@"Toggle Polling" action:@selector(togglePolling:) keyEquivalent:empty];
		[item setTarget:self];
		[item setTag:togglePollingTag];
	}

	return [menu autorelease];
}

- (BOOL)validateMenuItem:(NSMenuItem *)item {
	switch([item tag]) {
		case launchQuitiTunesTag:;
			static NSString *names[2] = { @"Launch iTunes", @"Quit iTunes" };
			[item setTitle:names[[self iTunesIsRunning] != NO]];
		case quitGrowlTunesTag:
			return YES;

		case quitBothTag:
			return [self iTunesIsRunning];

		case togglePollingTag:
			if(pollTimer)
				[item setTitle:@"Stop Polling"];
			else
				[item setTitle:@"Start Polling"];
			return YES;

		case onlineHelp:
		    return YES;
		    
		default:
			return NO;
	}
}

- (IBAction)togglePolling:(id)sender {
	if(pollTimer)
		[self stopTimer];
	else
		[self startTimer];
}

- (IBAction)onlineHelp:(id)sender{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:ONLINE_HELP_URL]];
}
    
- (IBAction)quitGrowlTunes:(id)sender {
	[NSApp terminate:sender];
}

- (IBAction)launchQuitiTunes:(id)sender {
	if(![self quitiTunes]) {
		//quit failed, so it wasn't running: launch it.
		[[NSWorkspace sharedWorkspace] launchApplication:iTunesAppName];
	}
}

- (IBAction)quitBoth:(id)sender {
	[self quitiTunes];
	[self quitGrowlTunes:sender];
}

- (BOOL)quitiTunes {
	NSDictionary *iTunes = [self iTunesProcess];
	BOOL success = (iTunes != nil);
	if(success) {
		//first disarm the timer. we don't want to launch iTunes right after we quit it if the timer fires.
		[self stopTimer];
		
		//now quit iTunes.
		NSDictionary *errorInfo = nil;
		[quitiTunesScript executeAndReturnError:&errorInfo];
	}
	return success;
}

#pragma mark AppleScript

- (NSAppleScript *)appleScriptNamed:(NSString *)name
{
	NSURL			* url;
	NSDictionary	* error;
	
	url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"scpt"]];
	
	return [[NSAppleScript alloc] initWithContentsOfURL:url error:&error];
}

- (BOOL)iTunesIsRunning {
	return [self iTunesProcess] != nil;
}
- (NSDictionary *)iTunesProcess {
	NSEnumerator *processesEnum = [[[NSWorkspace sharedWorkspace] launchedApplications] objectEnumerator];
	NSDictionary *process;
	
	while(process = [processesEnum nextObject]) {
		if([iTunesBundleID caseInsensitiveCompare:[process objectForKey:@"NSApplicationBundleIdentifier"]] == NSOrderedSame)
			break; //this is iTunes!
	}

	return process;
}

- (void)handleAppLaunch:(NSNotification *)notification {
	if([iTunesBundleID caseInsensitiveCompare:[[notification userInfo] objectForKey:@"NSApplicationBundleIdentifier"]] == NSOrderedSame)
		[self startTimer];
}
- (void)handleAppQuit:(NSNotification *)notification {
	if([iTunesBundleID caseInsensitiveCompare:[[notification userInfo] objectForKey:@"NSApplicationBundleIdentifier"]] == NSOrderedSame)
		[self stopTimer];
}

#pragma mark Plug-ins

- (NSMutableArray *)loadPlugins {
	NSMutableArray *newPlugins = [[NSMutableArray alloc] init];
	if(newPlugins) {
		NSBundle *myBundle = [NSBundle mainBundle];
		NSString *pluginsPath = [myBundle builtInPlugInsPath];
		static NSString *pluginPathExtension = @"plugin";

		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

		NSDirectoryEnumerator *pluginEnum = [[NSFileManager defaultManager] enumeratorAtPath:pluginsPath];
		NSString *curPath;
		while(curPath = [pluginEnum nextObject]) {
			if([[curPath pathExtension] isEqualToString:pluginPathExtension]) {
				curPath = [pluginsPath stringByAppendingPathComponent:curPath];
				NSBundle *plugin = [NSBundle bundleWithPath:curPath];
				id instance = [[[[plugin principalClass] alloc] init] autorelease];
				[newPlugins addObject:instance];
				NSLog(@"Loaded plug-in \"%@\" with id %p", [curPath lastPathComponent], instance);
			}
		}

		[pool release];
		[newPlugins autorelease];
	}
	return newPlugins;
}

@end

@implementation NSObject(GrowlTunesDummyPlugin)

- (NSImage *)artworkForTitle:(NSString *)track
					byArtist:(NSString *)artist
					 onAlbum:(NSString *)album
{
	NSLog(@"Dummy plug-in %p called for artwork", self);
	return nil;
}

@end
