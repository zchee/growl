FasdUAS 1.101.10   ��   ��    k             i         I      �������� @0 getphotofromaddressbookroutine getPhotoFromAddressBookRoutine��  ��    k      	 	  
  
 O         r        n    	    1    	��
�� 
az50  1    ��
�� 
az54  o      ���� 0 	icon_data    m       �                                                                                  adrb  alis    >  Beta                       �|��H+   L�rContacts.app                                                    MjMˆD�        ����  	                Applications    �|�
      ˆ|�     L�r  Beta:Applications: Contacts.app     C o n t a c t s . a p p  
  B e t a  Applications/Contacts.app   / ��     ��  L       o    ���� 0 	icon_data  ��        l     ��������  ��  ��        l     ����  O         r        ?        l     ����   I   �� !��
�� .corecnte****       **** ! l    "���� " 6    # $ # 2    ��
�� 
prcs $ =    % & % 1   	 ��
�� 
bnid & m     ' ' � ( ( 0 c o m . G r o w l . G r o w l H e l p e r A p p��  ��  ��  ��  ��    m    ����    o      ���� 0 	isrunning 	isRunning  m      ) )�                                                                                  sevs  alis    z  Beta                       �|��H+   L�USystem Events.app                                               O��Ɖ        ����  	                CoreServices    �|�
      ���     L�U L�O L�N  5Beta:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p  
  B e t a  -System/Library/CoreServices/System Events.app   / ��  ��  ��     * + * l     ��������  ��  ��   +  ,�� , l  � -���� - Z   � . /���� . o    ���� 0 	isrunning 	isRunning / O   � 0 1 0 k   &� 2 2  3 4 3 l  & &��������  ��  ��   4  5 6 5 l  & &�� 7 8��   7 1 + Make a list of all the notification types     8 � 9 9 V   M a k e   a   l i s t   o f   a l l   t h e   n o t i f i c a t i o n   t y p e s   6  : ; : l  & &�� < =��   < ' ! that this script will ever send:    = � > > B   t h a t   t h i s   s c r i p t   w i l l   e v e r   s e n d : ;  ? @ ? r   & , A B A l 	 & * C���� C J   & * D D  E F E m   & ' G G � H H " T e s t   N o t i f i c a t i o n F  I�� I m   ' ( J J � K K 2 A n o t h e r   T e s t   N o t i f i c a t i o n��  ��  ��   B l      L���� L o      ���� ,0 allnotificationslist allNotificationsList��  ��   @  M N M l  - -��������  ��  ��   N  O P O l  - -�� Q R��   Q ( " Make a list of the notifications     R � S S D   M a k e   a   l i s t   o f   t h e   n o t i f i c a t i o n s   P  T U T l  - -�� V W��   V - ' that will be enabled by default.          W � X X N   t h a t   w i l l   b e   e n a b l e d   b y   d e f a u l t .             U  Y Z Y l  - -�� [ \��   [ 9 3 Those not enabled by default can be enabled later     \ � ] ] f   T h o s e   n o t   e n a b l e d   b y   d e f a u l t   c a n   b e   e n a b l e d   l a t e r   Z  ^ _ ^ l  - -�� ` a��   ` 7 1 in the 'Applications' tab of the growl prefpane.    a � b b b   i n   t h e   ' A p p l i c a t i o n s '   t a b   o f   t h e   g r o w l   p r e f p a n e . _  c d c r   - 2 e f e l 	 - 0 g���� g J   - 0 h h  i�� i m   - . j j � k k " T e s t   N o t i f i c a t i o n��  ��  ��   f l      l���� l o      ���� 40 enablednotificationslist enabledNotificationsList��  ��   d  m n m l  3 3��������  ��  ��   n  o p o l  3 3�� q r��   q &   Register our script with growl.    r � s s @   R e g i s t e r   o u r   s c r i p t   w i t h   g r o w l . p  t u t l  3 3�� v w��   v 7 1 You can optionally (as here) set a default icon     w � x x b   Y o u   c a n   o p t i o n a l l y   ( a s   h e r e )   s e t   a   d e f a u l t   i c o n   u  y z y l  3 3�� { |��   { ' ! for this script's notifications.    | � } } B   f o r   t h i s   s c r i p t ' s   n o t i f i c a t i o n s . z  ~  ~ I  3 L���� �
�� .registernull��� ��� null��   � �� � �
�� 
appl � l 	 5 8 ����� � m   5 8 � � � � � 0 G r o w l   A p p l e S c r i p t   S a m p l e��  ��   � �� � �
�� 
anot � l 
 ; < ����� � o   ; <���� ,0 allnotificationslist allNotificationsList��  ��   � �� � �
�� 
dnot � l 
 ? @ ����� � o   ? @���� 40 enablednotificationslist enabledNotificationsList��  ��   � �� ���
�� 
iapp � m   C F � � � � � $ A p p l e S c r i p t   E d i t o r��     � � � l  M M��������  ��  ��   �  � � � l  M M�� � ���   � #        Send a Notification...    � � � � :               S e n d   a   N o t i f i c a t i o n . . . �  � � � l  M M��������  ��  ��   �  � � � l  M M��������  ��  ��   �  � � � l  M M�� � ���   �  
	No icon.	    � � � �  	 N o   i c o n . 	 �  � � � I  M j���� �
�� .notifygrnull��� ��� null��   � �� � �
�� 
name � l 	 Q T ����� � m   Q T � � � � � " T e s t   N o t i f i c a t i o n��  ��   � �� � �
�� 
titl � l 	 W Z ����� � m   W Z � � � � � " T e s t   N o t i f i c a t i o n��  ��   � �� � �
�� 
desc � l 	 ] ` ����� � m   ] ` � � � � � . N o   i c o n   p r o v i d e d   b y   u s .��  ��   � �� ���
�� 
appl � m   a d � � � � � 0 G r o w l   A p p l e S c r i p t   S a m p l e��   �  � � � l  k k��������  ��  ��   �  � � � l  k k�� � ���   �  	Absolute path icon.	    � � � � * 	 A b s o l u t e   p a t h   i c o n . 	 �  � � � I  k ����� �
�� .notifygrnull��� ��� null��   � �� � �
�� 
name � l 	 o r ����� � m   o r � � � � � " T e s t   N o t i f i c a t i o n��  ��   � �� � �
�� 
titl � l 	 u x ����� � m   u x � � � � � " T e s t   N o t i f i c a t i o n��  ��   � �� � �
�� 
desc � l 	 { ~ ����� � m   { ~ � � � � � * I c o n   f r o m   P O S I X   p a t h .��  ��   � �� � �
�� 
appl � m    � � � � � � 0 G r o w l   A p p l e S c r i p t   S a m p l e � �� ���
�� 
iurl � m   � � � � � � � � / S y s t e m / L i b r a r y / C o r e S e r v i c e s / l o g i n w i n d o w . a p p / C o n t e n t s / R e s o u r c e s / L o g O u t . p n g��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  	 icon from alias.	    � � � � & 	   i c o n   f r o m   a l i a s . 	 �  � � � I  � ����� �
�� .notifygrnull��� ��� null��   � �� � �
�� 
name � l 	 � � ���� � m   � � � � � � � " T e s t   N o t i f i c a t i o n��  �   � �~ � �
�~ 
titl � l 	 � � ��}�| � m   � � � � � � � " T e s t   N o t i f i c a t i o n�}  �|   � �{ � �
�{ 
desc � l 	 � � ��z�y � m   � � � � � � �   I c o n   f r o m   a l i a s .�z  �y   � �x � �
�x 
appl � m   � � � � � � � 0 G r o w l   A p p l e S c r i p t   S a m p l e � �w ��v
�w 
iurl � l  � � ��u�t � c   � � � � � m   � � � � � � � � : S y s t e m : L i b r a r y : C o r e S e r v i c e s : l o g i n w i n d o w . a p p : C o n t e n t s : R e s o u r c e s : L o g O u t . p n g � m   � ��s
�s 
alis�u  �t  �v   �  � � � l  � ��r�q�p�r  �q  �p   �  � � � l  � ��o � ��o   �  		delay 10    � � � �  	 d e l a y   1 0 �  � � � l  � ��n�m�l�n  �m  �l   �    l  � ��k�k    	Icon Of File    �  	 I c o n   O f   F i l e  I  � ��j�i
�j .notifygrnull��� ��� null�i   �h	
�h 
name l 	 � �
�g�f
 m   � � � " T e s t   N o t i f i c a t i o n�g  �f  	 �e
�e 
titl l 	 � ��d�c m   � � � " T e s t   N o t i f i c a t i o n�d  �c   �b
�b 
desc l 	 � ��a�` m   � � � 4 I c o n   o f   F i l e .   ( a n d   S t i c k y )�a  �`   �_
�_ 
appl m   � � � 0 G r o w l   A p p l e S c r i p t   S a m p l e �^
�^ 
ifil m   � � �  ~ / �]�\
�] 
stck m   � ��[
�[ boovtrue�\    !  l  � ��Z�Y�X�Z  �Y  �X  ! "#" l  � ��W$%�W  $  icon from application   % �&& * i c o n   f r o m   a p p l i c a t i o n# '(' I  ��V�U)
�V .notifygrnull��� ��� null�U  ) �T*+
�T 
name* l 	 � �,�S�R, m   � �-- �.. " T e s t   N o t i f i c a t i o n�S  �R  + �Q/0
�Q 
titl/ l 	 � �1�P�O1 m   � �22 �33 " T e s t   N o t i f i c a t i o n�P  �O  0 �N45
�N 
desc4 l 	 � �6�M�L6 m   � �77 �88  M e s s a g e   3�M  �L  5 �K9:
�K 
appl9 m   � �;; �<< 0 G r o w l   A p p l e S c r i p t   S a m p l e: �J=�I
�J 
iapp= m   � �>> �??  i T u n e s . a p p�I  ( @A@ l �H�G�F�H  �G  �F  A BCB l �EDE�E  D  
TIFF Image   E �FF  T I F F   I m a g eC GHG r  IJI n KLK I  �D�C�B�D @0 getphotofromaddressbookroutine getPhotoFromAddressBookRoutine�C  �B  L  f  J o      �A�A 0 tiffdata TIFFdataH MNM I 0�@�?O
�@ .notifygrnull��� ��� null�?  O �>PQ
�> 
nameP l 	R�=�<R m  SS �TT 2 A n o t h e r   T e s t   N o t i f i c a t i o n�=  �<  Q �;UV
�; 
titlU l 	W�:�9W m  XX �YY V T h i s   i s   a   N o t i f i c a t i o n   w i t h   T I F F   I m a g e   D a t a�:  �9  V �8Z[
�8 
descZ l 	 \�7�6\ m   ]] �^^ 2 W e   a r e   u s i n g   T I F F   d a t a . . .�7  �6  [ �5_`
�5 
appl_ m  !$aa �bb 0 G r o w l   A p p l e S c r i p t   S a m p l e` �4c�3
�4 
imagc o  '*�2�2 0 tiffdata TIFFdata�3  N ded l 11�1�0�/�1  �0  �/  e fgf l 11�.hi�.  h  coalescing	   i �jj  c o a l e s c i n g 	g klk I 1T�-�,m
�- .notifygrnull��� ��� null�,  m �+no
�+ 
namen l 	58p�*�)p m  58qq �rr " T e s t   N o t i f i c a t i o n�*  �)  o �(st
�( 
titls l 	;>u�'�&u m  ;>vv �ww " T e s t   N o t i f i c a t i o n�'  �&  t �%xy
�% 
descx l 	ADz�$�#z m  AD{{ �||  M e s s a g e   1�$  �#  y �"}~
�" 
appl} m  EH ��� 0 G r o w l   A p p l e S c r i p t   S a m p l e~ �!�� 
�! 
iden� m  KN�� ���  i d�   l ��� l UU����  �  �  � ��� I UZ���
� .sysodelanull��� ��� nmbr� m  UV�� �  � ��� I [~���
� .notifygrnull��� ��� null�  � ���
� 
name� l 	_b���� m  _b�� ��� " T e s t   N o t i f i c a t i o n�  �  � ���
� 
titl� l 	eh���� m  eh�� ��� " T e s t   N o t i f i c a t i o n�  �  � ���
� 
desc� l 	kn���� m  kn�� ���  M e s s a g e   2�  �  � ���
� 
appl� m  or�� ��� 0 G r o w l   A p p l e S c r i p t   S a m p l e� ���
� 
iden� m  ux�� ���  i d�  � ��� l �
�	��
  �	  �  �   1 5    #���
� 
capp� m     !�� ��� 0 c o m . G r o w l . G r o w l H e l p e r A p p
� kfrmID  ��  ��  ��  ��  ��       �����  � ��� @0 getphotofromaddressbookroutine getPhotoFromAddressBookRoutine
� .aevtoappnull  �   � ****� � �� ����� @0 getphotofromaddressbookroutine getPhotoFromAddressBookRoutine�  �   � ���� 0 	icon_data  �  ����
�� 
az54
�� 
az50�� � 	*�,�,E�UO�� �����������
�� .aevtoappnull  �   � ****� k    ���  ��  ,����  ��  ��  �  � L )����� '��������� G J�� j���� ������� ������� ��� ��� � ��� � � � ��� ��� � � � � ���������-27;>����SX]a��qv{����������
�� 
prcs�  
�� 
bnid
�� .corecnte****       ****�� 0 	isrunning 	isRunning
�� 
capp
�� kfrmID  �� ,0 allnotificationslist allNotificationsList�� 40 enablednotificationslist enabledNotificationsList
�� 
appl
�� 
anot
�� 
dnot
�� 
iapp�� 
�� .registernull��� ��� null
�� 
name
�� 
titl
�� 
desc
�� .notifygrnull��� ��� null
�� 
iurl�� 

�� 
alis
�� 
ifil
�� 
stck�� �� @0 getphotofromaddressbookroutine getPhotoFromAddressBookRoutine�� 0 tiffdata TIFFdata
�� 
imag
�� 
iden
�� .sysodelanull��� ��� nmbr���� *�-�[�,\Z�81j jE�UO�h)���0\��lvE�O�kvE�O*�a a �a �a a a  O*a a a a a a �a a  O*a a a a  a a !�a "a #a $a % O*a a &a a 'a a (�a )a #a *a +&a % O*a a ,a a -a a .�a /a 0a 1a 2ea 3 O*a a 4a a 5a a 6�a 7a a 8a % O)j+ 9E` :O*a a ;a a <a a =�a >a ?_ :a % O*a a @a a Aa a B�a Ca Da Ea % Olj FO*a a Ga a Ha a I�a Ja Da Ka % OPUY hascr  ��ޭ