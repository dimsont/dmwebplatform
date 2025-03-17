Š
fC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.DataAccess\NotificationDbContextFactory.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &

DataAccess& 0
{ 
public 

class (
NotificationDbContextFactory -
:. /'
IDesignTimeDbContextFactory0 K
<K L!
NotificationDbContextL a
>a b
{ 
public		 !
NotificationDbContext		 $
CreateDbContext		% 4
(		4 5
string		5 ;
[		; <
]		< =
args		> B
)		B C
{

 	
var 
configuration 
= 
new  # 
ConfigurationBuilder$ 8
(8 9
)9 :
. 
SetBasePath 
( 
	Directory &
.& '
GetCurrentDirectory' :
(: ;
); <
)< =
. 
AddJsonFile 
( 
$str /
)/ 0
. 
Build 
( 
) 
; 
var 
connectionString  
=! "
configuration# 0
.0 1
GetConnectionString1 D
(D E
$strE X
)X Y
;Y Z
var 
optionsBuilder 
=  
new! $#
DbContextOptionsBuilder% <
<< =!
NotificationDbContext= R
>R S
(S T
)T U
;U V
optionsBuilder 
. 
UseSqlServer '
(' (
connectionString( 8
)8 9
;9 :
return 
new !
NotificationDbContext ,
(, -
optionsBuilder- ;
.; <
Options< C
)C D
;D E
} 	
} 
} ƒ

_C:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.DataAccess\NotificationDbContext.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &

DataAccess& 0
{ 
public 

class !
NotificationDbContext &
:' (
	DbContext) 2
{ 
public 
virtual 
DbSet 
< 
Notification )
>) *
Notifications+ 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
public		 !
NotificationDbContext		 $
(		$ %
DbContextOptions		% 5
<		5 6!
NotificationDbContext		6 K
>		K L
options		M T
)		T U
:		V W
base		X \
(		\ ]
options		] d
)		d e
{

 	
} 	
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
base 
. 
OnModelCreating  
(  !
modelBuilder! -
)- .
;. /
} 	
} 
} ß
qC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.DataAccess\Migrations\20240904084941_InitialCreate.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &

DataAccess& 0
.0 1

Migrations1 ;
{ 
public		 

partial		 
class		 
InitialCreate		 &
:		' (
	Migration		) 2
{

 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str %
,% &
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 6
,6 7
nullable8 @
:@ A
falseB G
)G H
. 

Annotation #
(# $
$str$ 8
,8 9
$str: @
)@ A
,A B
EventId 
= 
table #
.# $
Column$ *
<* +
int+ .
>. /
(/ 0
type0 4
:4 5
$str6 ;
,; <
nullable= E
:E F
falseG L
)L M
,M N
Email 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 F
,F G
nullableH P
:P Q
falseR W
)W X
,X Y
NotificationTime $
=% &
table' ,
., -
Column- 3
<3 4
DateTime4 <
>< =
(= >
type> B
:B C
$strD O
,O P
nullableQ Y
:Y Z
false[ `
)` a
,a b
IsSent 
= 
table "
." #
Column# )
<) *
bool* .
>. /
(/ 0
type0 4
:4 5
$str6 ;
,; <
nullable= E
:E F
falseG L
)L M
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 7
,7 8
x9 :
=>; =
x> ?
.? @
Id@ B
)B C
;C D
} 
) 
; 
} 	
	protected   
override   
void   
Down    $
(  $ %
MigrationBuilder  % 5
migrationBuilder  6 F
)  F G
{!! 	
migrationBuilder"" 
."" 
	DropTable"" &
(""& '
name## 
:## 
$str## %
)##% &
;##& '
}$$ 	
}%% 
}&& ´
SC:\Users\Dima\dmwebplatform_git\DmWebPlatform.Notifications.DataAccess\DbFactory.cs
	namespace 	
DmWebPlatform
 
. 
Notifications %
.% &

DataAccess& 0
{ 
public 

class 
	DbFactory 
: 
IDisposable (
{ 
private 
bool 
	_disposed 
; 
private 
readonly 
Func 
< !
NotificationDbContext 3
>3 4
_instanceFunc5 B
;B C
private		 
	DbContext		 

_dbContext		 $
;		$ %
public

 
	DbContext

 
	DbContext

 "
=>

# %

_dbContext

& 0
??=

1 4
_instanceFunc

5 B
.

B C
Invoke

C I
(

I J
)

J K
;

K L
public 
	DbFactory 
( 
Func 
< !
NotificationDbContext 3
>3 4
dbContextFactory5 E
)E F
{ 	
_instanceFunc 
= 
dbContextFactory ,
;, -
} 	
public 
void 
Dispose 
( 
) 
{ 	
if 
( 
! 
	_disposed 
&& 

_dbContext (
!=) +
null, 0
)0 1
{ 
	_disposed 
= 
true  
;  !

_dbContext 
. 
Dispose "
(" #
)# $
;$ %
} 
} 	
} 
} 