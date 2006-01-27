//
//  GrowlPreferencePane.h
//  Growl
//
//  Created by Karl Adam on Wed Apr 21 2004.
//  Copyright 2004-2006 The Growl Project. All rights reserved.
//
// This file is under the BSD License, refer to License.txt for details

#import <PreferencePanes/PreferencePanes.h>

@class GrowlApplicationTicket, TicketsArrayController, GrowlPluginController, GrowlPreferencesController, GrowlPlugin;

@interface GrowlPreferencePane : NSPreferencePane {
	int                             pid;

	CFMutableArrayRef               images;
	NSMutableArray					*tickets;
	NSArray							*plugins;

	NSPreferencePane				*pluginPrefPane;
	NSMutableArray					*loadedPrefPanes;

	//Properties of the plugin being configured
	NSDictionary					*currentPlugin;
	GrowlPlugin						*currentPluginController;

	BOOL                            canRemoveTicket;
	BOOL                            growlIsRunning;

	NSURL							*versionCheckURL;

	//cached controllers
	/*these are cached to avoid redundant calls to
	 *	[GrowlXController sharedController].
	 *though that method also caches its return value, we're dealing with
	 *	Bindings here, so we want to pick up all the speed boosts that we can.
	 */
	GrowlPluginController			*pluginController;
	GrowlPreferencesController		*preferencesController;

	//"General" tab pane
	IBOutlet NSButton				*startStopGrowl;
	IBOutlet NSTextField			*growlRunningStatus;
	IBOutlet NSProgressIndicator	*growlRunningProgress;
	IBOutlet NSProgressIndicator	*growlVersionProgress;
	IBOutlet NSArrayController		*notificationsArrayController;

	// Logging
	IBOutlet NSMatrix				*logFileType;
	IBOutlet NSPopUpButton			*customMenuButton;
	CFMutableArrayRef               customHistArray;

	//"Applications" tab pane
	IBOutlet NSTableView			*growlApplications;
	IBOutlet NSTableColumn			*applicationNameAndIconColumn;
	IBOutlet NSTabView				*applicationsTab;
	NSTableView						*activeTableView;
	IBOutlet NSMenu					*notificationPriorityMenu;
	IBOutlet TicketsArrayController	*ticketsArrayController;

	//"Display Options" tab pane
	IBOutlet NSTableView			*displayPluginsTable;
	IBOutlet NSView					*displayPrefView;
	IBOutlet NSView					*displayDefaultPrefView;
	IBOutlet NSTextField			*displayAuthor;
	IBOutlet NSTextField			*displayVersion;
	IBOutlet NSButton				*previewButton;
	IBOutlet NSArrayController		*displayPluginsArrayController;

	//"Network" tab pane
	NSMutableArray					*services;
	NSNetServiceBrowser				*browser;
	NSNetService					*serviceBeingResolved;
	int								currentServiceIndex;
	IBOutlet NSArrayController		*servicesArrayController;
	IBOutlet NSTableColumn			*servicePasswordColumn;

	//About box tab pane
	IBOutlet NSTextView				*aboutBoxTextView;
	NSURL							*growlWebSiteURL;
	NSURL							*growlForumURL;
	NSURL							*growlTracURL;
	NSURL							*growlDonateURL;
}

- (NSString *) bundleVersion;
- (IBAction) checkVersion:(id)sender;
- (void) downloadSelector:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;

- (void) reloadPreferences:(NSString *)object;
- (void) updateRunningStatus;

#pragma mark Bindings accessors (not for programmatic use)

- (GrowlPluginController *) pluginController;
- (GrowlPreferencesController *) preferencesController;

#pragma mark "Applications" tab pane
- (BOOL) canRemoveTicket;
- (void) setCanRemoveTicket:(BOOL)flag;
- (IBAction) deleteTicket:(id)sender;

#pragma mark "General" tab pane
- (IBAction) startStopGrowl:(id)sender;
- (BOOL) growlIsRunning;
- (void) setGrowlIsRunning:(BOOL)flag;
- (void) updateLogPopupMenu;

#pragma mark GrowlMenu methods
+ (BOOL) isGrowlMenuRunning;

#pragma mark "Network" tab pane
- (IBAction) resolveService:(id)sender;
- (void) writeForwardDestinations;

- (NSMutableArray *) services;
- (void) setServices:(NSMutableArray *)theServices;
- (unsigned) countOfServices;
- (void) insertObject:(id)anObject inServicesAtIndex:(unsigned)index;
- (void) replaceObjectInServicesAtIndex:(unsigned)index withObject:(id)anObject;

#pragma mark "Display Options" tab pane
- (IBAction) showPreview:(id)sender;
- (void) loadViewForDisplay:(NSString*)displayName;

- (NSArray *) displayPlugins;
- (void) setDisplayPlugins:(NSArray *)thePlugins;

- (void) checkGrowlRunning;
- (void) appRegistered: (NSNotification *) note;

#pragma mark About Tab methods
- (void) setupAboutTab;
- (IBAction) openGrowlWebSite:(id)sender;
- (IBAction) openGrowlForum:(id)sender;
- (IBAction) openGrowlTrac:(id)sender;
- (IBAction) openGrowlDonate:(id)sender;

@end
