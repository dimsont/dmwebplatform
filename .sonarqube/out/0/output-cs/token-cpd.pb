Ë
TC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.Domain\MappingProfile.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &
Domain& ,
{ 
public 

class 
MappingProfile 
:  !
Profile" )
{		 
public

 
MappingProfile

 
(

 
)

 
{ 	
	CreateMap 
< 
Notification "
," #
NotificationDto$ 3
>3 4
(4 5
)5 6
.6 7

ReverseMap7 A
(A B
)B C
;C D
} 	
} 
} ú
[C:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.Domain\Entities\Notification.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &
Domain& ,
., -
Entities- 5
{ 
public 

class 
Notification 
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
int 
EventId 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
DateTime 
NotificationTime (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public		 
bool		 
IsSent		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
}

 
} ø
ZC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.Domain\DTOs\NotificationDto.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &
Domain& ,
., -
DTOs- 1
{ 
public 

class 
NotificationDto  
{ 
public 
int 
Id 
{ 
get 
; 
set  
;  !
}" #
public 
int 
EventId 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
DateTime 
NotificationTime (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
public		 
bool		 
IsSent		 
{		 
get		  
;		  !
set		" %
;		% &
}		' (
}

 
} 