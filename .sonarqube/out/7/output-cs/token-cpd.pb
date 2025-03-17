Ã.
ZC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.Service\NotificationService.cs
public 
class 
NotificationService  
:! " 
INotificationService# 7
{ 
private		 
readonly		 
IUnitOfWork		  
_unitOfWork		! ,
;		, -
private

 
readonly

 
IRepository

  
<

  !
Notification

! -
>

- .#
_notificationRepository

/ F
;

F G
private 
readonly 
IMapper 
_mapper $
;$ %
public 

NotificationService 
( 
IUnitOfWork *

unitOfWork+ 5
,5 6
IMapper7 >
mapper? E
)E F
{ 
_unitOfWork 
= 

unitOfWork  
;  !#
_notificationRepository 
=  !
_unitOfWork" -
.- .

Repository. 8
<8 9
Notification9 E
>E F
(F G
)G H
;H I
_mapper 
= 
mapper 
; 
} 
public 

async 
Task 
AddSubscription %
(% &
NotificationDto& 5
notificationDto6 E
)E F
{ 
var 
notification 
= 
_mapper "
." #
Map# &
<& '
Notification' 3
>3 4
(4 5
notificationDto5 D
)D E
;E F
await #
_notificationRepository %
.% &
InsertAsync& 1
(1 2
notification2 >
)> ?
;? @
await 
_unitOfWork 
. 
SaveChangesAsync *
(* +
)+ ,
;, -
} 
public 

async 
Task 
< 
IList 
< 
NotificationDto +
>+ ,
>, -
GetNotifications. >
(> ?
int? B
eventIdC J
)J K
{ 
var 
notifications 
= 
await !#
_notificationRepository" 9
.9 :
GetAllAsync: E
(E F
)F G
;G H
var 
eventNotification 
= 
notifications  -
.- .
Where. 3
(3 4
s4 5
=>6 8
s9 :
.: ;
EventId; B
==C E
eventIdF M
)M N
.N O
ToListO U
(U V
)V W
;W X
return 
_mapper 
. 
Map 
< 
IList  
<  !
NotificationDto! 0
>0 1
>1 2
(2 3
eventNotification3 D
)D E
;E F
}   
public"" 

async"" 
Task"" 
RemoveSubscription"" (
(""( )
int"") ,
notificationId""- ;
)""; <
{## 
var$$ 
notification$$ 
=$$ 
await$$  #
_notificationRepository$$! 8
.$$8 9
	FindAsync$$9 B
($$B C
notificationId$$C Q
)$$Q R
;$$R S
if%% 

(%% 
notification%% 
!=%% 
null%%  
)%%  !
{&& 	
await'' #
_notificationRepository'' )
.'') *
DeleteAsync''* 5
(''5 6
notification''6 B
)''B C
;''C D
await(( 
_unitOfWork(( 
.(( 
SaveChangesAsync(( .
(((. /
)((/ 0
;((0 1
})) 	
}** 
public,, 

async,, 
Task,, 
<,, 
IEnumerable,, !
<,,! "
NotificationDto,," 1
>,,1 2
>,,2 3)
GetNotificationsForEventAsync,,4 Q
(,,Q R
int,,R U
eventId,,V ]
),,] ^
{-- 
var.. 
notifications.. 
=.. 
await.. !#
_notificationRepository.." 9
...9 :
GetAllAsync..: E
(..E F
)..F G
;..G H
var// 
eventNotification// 
=// 
notifications//  -
.//- .
Where//. 3
(//3 4
s//4 5
=>//6 8
s//9 :
.//: ;
EventId//; B
==//C E
eventId//F M
)//M N
;//N O
return00 
_mapper00 
.00 
Map00 
<00 
IEnumerable00 &
<00& '
NotificationDto00' 6
>006 7
>007 8
(008 9
eventNotification009 J
)00J K
;00K L
}11 
public33 

async33 
Task33 "
SendNotificationsAsync33 ,
(33, -
)33- .
{44 
var55 
notifications55 
=55 
await55 !#
_notificationRepository55" 9
.559 :
GetAllAsync55: E
(55E F
)55F G
;55G H
foreach66 
(66 
var66 
notification66 !
in66" $
notifications66% 2
)662 3
{77 	
var88 
notificationTime88  
=88! "
notification88# /
.88/ 0
NotificationTime880 @
;88@ A
if99 
(99 
notificationTime99  
<=99! #
DateTime99$ ,
.99, -
UtcNow99- 3
)993 4
{:: 
}>> 
}?? 	
awaitAA 
_unitOfWorkAA 
.AA 
SaveChangesAsyncAA *
(AA* +
)AA+ ,
;AA, -
}BB 
}CC 