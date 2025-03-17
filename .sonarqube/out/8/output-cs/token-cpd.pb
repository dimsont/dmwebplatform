Ì
EC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Service\TokenService.cs
	namespace

 	
DmWebPlatform


 
.

 
Service

 
{ 
public 

class 
TokenService 
: 
ITokenService  -
{ 
private 
readonly 
UserManager $
<$ %
ApplicationUser% 4
>4 5
_userManager6 B
;B C
private 
readonly 
IConfiguration '
_configuration( 6
;6 7
public 
TokenService 
( 
UserManager '
<' (
ApplicationUser( 7
>7 8
userManager9 D
,D E
IConfigurationF T
configurationU b
)b c
{ 	
_userManager 
= 
userManager &
;& '
_configuration 
= 
configuration *
;* +
} 	
public 
async 
Task 
< 
string  
>  !
GenerateToken" /
(/ 0
ApplicationUser0 ?
user@ D
)D E
{ 	
var 
	userRoles 
= 
await !
_userManager" .
.. /
GetRolesAsync/ <
(< =
user= A
.A B
IdB D
)D E
;E F
var 
claims 
= 
new 
List !
<! "
Claim" '
>' (
{ 	
new 
Claim 
( #
JwtRegisteredClaimNames -
.- .
Sub. 1
,1 2
user3 7
.7 8
UserName8 @
)@ A
,A B
new 
Claim 
( #
JwtRegisteredClaimNames -
.- .
Jti. 1
,1 2
Guid3 7
.7 8
NewGuid8 ?
(? @
)@ A
.A B
ToStringB J
(J K
)K L
)L M
} 	
;	 

foreach   
(   
var   
role   
in    
	userRoles  ! *
)  * +
{!! 
claims"" 
."" 
Add"" 
("" 
new"" 
Claim"" $
(""$ %

ClaimTypes""% /
.""/ 0
Role""0 4
,""4 5
role""6 :
)"": ;
)""; <
;""< =
}## 
var%% 
key%% 
=%% 
new%%  
SymmetricSecurityKey%% .
(%%. /
Encoding%%/ 7
.%%7 8
ASCII%%8 =
.%%= >
GetBytes%%> F
(%%F G
_configuration%%G U
[%%U V
$str%%V k
]%%k l
)%%l m
)%%m n
;%%n o
var&& 
creds&& 
=&& 
new&& 
SigningCredentials&& .
(&&. /
key&&/ 2
,&&2 3
SecurityAlgorithms&&4 F
.&&F G

HmacSha256&&G Q
)&&Q R
;&&R S
var'' 
token'' 
='' 
new'' 
JwtSecurityToken'' ,
('', -
issuer(( 
:(( 
null(( 
,(( 
audience)) 
:)) 
null)) 
,)) 
claims** 
:** 
claims** 
,** 
expires++ 
:++ 
DateTime++ !
.++! "
Now++" %
.++% &
AddHours++& .
(++. /
$num++/ 0
)++0 1
,++1 2
signingCredentials,, "
:,," #
creds,,$ )
)-- 
;-- 
return// 
new// #
JwtSecurityTokenHandler// .
(//. /
)/// 0
.//0 1

WriteToken//1 ;
(//; <
token//< A
)//A B
;//B C
}00 	
}11 
}22 6
EC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Service\EventService.cs
public 
class 
EventService 
: 
IEventService )
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
  !
Event

! &
>

& '
_eventRepository

( 8
;

8 9
private 
readonly 
IMapper 
_mapper $
;$ %
private 
readonly 

HttpClient 
_httpClient  +
;+ ,
public 

EventService 
( 
IUnitOfWork #

unitOfWork$ .
,. /
IMapper0 7
mapper8 >
,> ?

HttpClient@ J

httpClientK U
)U V
{ 
_unitOfWork 
= 

unitOfWork  
;  !
_eventRepository 
= 
_unitOfWork &
.& '

Repository' 1
<1 2
Event2 7
>7 8
(8 9
)9 :
;: ;
_mapper 
= 
mapper 
; 
_httpClient 
= 

httpClient  
;  !
} 
public 

async 
Task 
< 
IList 
< 
EventDto $
>$ %
>% &
GetAll' -
(- .
). /
{ 
var 
events 
= 
await 
_eventRepository +
.+ ,
GetAllAsync, 7
(7 8
)8 9
;9 :
return 
_mapper 
. 
Map 
< 
IList  
<  !
EventDto! )
>) *
>* +
(+ ,
events, 2
)2 3
;3 4
} 
public 

async 
Task 
< 
EventDto 
> 
GetOne  &
(& '
int' *
eventId+ 2
)2 3
{ 
var 
	eventItem 
= 
await 
_eventRepository .
.. /
	FindAsync/ 8
(8 9
eventId9 @
)@ A
;A B
return 
_mapper 
. 
Map 
< 
EventDto #
># $
($ %
	eventItem% .
). /
;/ 0
}   
public"" 

async"" 
Task"" 
Add"" 
("" 
EventDto"" "

eventInput""# -
)""- .
{## 
var$$ 
	eventItem$$ 
=$$ 
_mapper$$ 
.$$  
Map$$  #
<$$# $
Event$$$ )
>$$) *
($$* +

eventInput$$+ 5
)$$5 6
;$$6 7
await%% 
_eventRepository%% 
.%% 
InsertAsync%% *
(%%* +
	eventItem%%+ 4
)%%4 5
;%%5 6
await&& 
_unitOfWork&& 
.&& 
SaveChangesAsync&& *
(&&* +
)&&+ ,
;&&, -
}'' 
public)) 

async)) 
Task)) 
Update)) 
()) 
EventDto)) %

eventInput))& 0
)))0 1
{** 
var++ 
	eventItem++ 
=++ 
await++ 
_eventRepository++ .
.++. /
	FindAsync++/ 8
(++8 9

eventInput++9 C
.++C D
Id++D F
)++F G
;++G H
if,, 

(,, 
	eventItem,, 
==,, 
null,, 
),, 
throw-- 
new--  
KeyNotFoundException-- *
(--* +
)--+ ,
;--, -
_mapper// 
.// 
Map// 
(// 

eventInput// 
,// 
	eventItem//  )
)//) *
;//* +
await00 
_unitOfWork00 
.00 
SaveChangesAsync00 *
(00* +
)00+ ,
;00, -
}11 
public33 

async33 
Task33 
Delete33 
(33 
int33  
eventId33! (
)33( )
{44 
var55 
	eventItem55 
=55 
await55 
_eventRepository55 .
.55. /
	FindAsync55/ 8
(558 9
eventId559 @
)55@ A
;55A B
if66 

(66 
	eventItem66 
==66 
null66 
)66 
throw77 
new77  
KeyNotFoundException77 *
(77* +
)77+ ,
;77, -
await99 
_eventRepository99 
.99 
DeleteAsync99 *
(99* +
	eventItem99+ 4
)994 5
;995 6
await:: 
_unitOfWork:: 
.:: 
SaveChangesAsync:: *
(::* +
)::+ ,
;::, -
};; 
public== 

async== 
Task== 
<== 
IList== 
<== 
EventDto== $
>==$ %
>==% &
SearchEventsAsync==' 8
(==8 9
string==9 ?

searchTerm==@ J
)==J K
{>> 
var?? 
events?? 
=?? 
await?? 
_eventRepository?? +
.??+ ,
GetAllAsync??, 7
(??7 8
)??8 9
;??9 :
varAA 
filteredEventsAA 
=AA 
eventsAA #
.BB 
WhereBB 
(BB 
eBB 
=>BB 
eBB 
.BB 
NameBB 
.BB 
ContainsBB '
(BB' (

searchTermBB( 2
,BB2 3
StringComparisonBB4 D
.BBD E
OrdinalIgnoreCaseBBE V
)BBV W
||BBX Z
eCC 
.CC 
DescriptionCC %
.CC% &
ContainsCC& .
(CC. /

searchTermCC/ 9
,CC9 :
StringComparisonCC; K
.CCK L
OrdinalIgnoreCaseCCL ]
)CC] ^
||CC_ a
eDD 
.DD 
PlaceDD 
.DD  
ContainsDD  (
(DD( )

searchTermDD) 3
,DD3 4
StringComparisonDD5 E
.DDE F
OrdinalIgnoreCaseDDF W
)DDW X
)DDX Y
.EE 
ToListEE 
(EE 
)EE 
;EE 
returnGG 
_mapperGG 
.GG 
MapGG 
<GG 
IListGG  
<GG  !
EventDtoGG! )
>GG) *
>GG* +
(GG+ ,
filteredEventsGG, :
)GG: ;
;GG; <
}HH 
}II ƒ
HC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Service\AuditLogService.cs
	namespace 	
DmWebPlatform
 
. 
Service 
{ 
public		 

class		 
AuditLogService		  
:		! "
IAuditLogService		# 3
{

 
private 
readonly 
IMongoCollection )
<) *
AuditLogEntry* 7
>7 8
_auditLogCollection9 L
;L M
private 
readonly  
IHttpContextAccessor - 
_httpContextAccessor. B
;B C
public 
AuditLogService 
( 
IMongoDatabase -
database. 6
,6 7 
IHttpContextAccessor8 L
httpContextAccessorM `
)` a
{ 	
_auditLogCollection 
=  !
database" *
.* +
GetCollection+ 8
<8 9
AuditLogEntry9 F
>F G
(G H
$strH S
)S T
;T U 
_httpContextAccessor  
=! "
httpContextAccessor# 6
;6 7
} 	
public 
async 
Task 
LogActionAsync (
(( )
AuditActionType) 8

actionType9 C
,C D
stringE K
payloadL S
)S T
{ 	
var 
user 
=  
_httpContextAccessor +
.+ ,
HttpContext, 7
?7 8
.8 9
User9 =
?= >
.> ?
Identity? G
?G H
.H I
NameI M
;M N
var 
logEntry 
= 
new 
AuditLogEntry ,
{ 
	Timestamp 
= 
DateTime $
.$ %
UtcNow% +
,+ ,
Action 
= 

actionType #
.# $
ToString$ ,
(, -
)- .
,. /
UserName 
= 
user 
,  
Payload 
= 
payload !
} 
; 
await!! 
_auditLogCollection!! %
.!!% &
InsertOneAsync!!& 4
(!!4 5
logEntry!!5 =
)!!= >
;!!> ?
}"" 	
public$$ 
async$$ 
Task$$ 
<$$ 
List$$ 
<$$ 
AuditLogEntry$$ ,
>$$, -
>$$- .
GetAuditLogsAsync$$/ @
($$@ A
)$$A B
{%% 	
return&& 
await&& 
_auditLogCollection&& ,
.&&, -
Find&&- 1
(&&1 2
_&&2 3
=>&&4 6
true&&7 ;
)&&; <
.&&< =
ToListAsync&&= H
(&&H I
)&&I J
;&&J K
}'' 	
}(( 
}** 