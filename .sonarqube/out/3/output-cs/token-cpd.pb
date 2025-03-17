ú
EC:\Users\Dima\dmwebplatform_git\DmWebPlatform.DataAccess\DbFactory.cs
	namespace 	
DmWebPlatform
 
. 

DataAccess "
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
<  
ApplicationDbContext 2
>2 3
_instanceFunc4 A
;A B
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
<  
ApplicationDbContext 2
>2 3
dbContextFactory4 D
)D E
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
} ô"
cC:\Users\Dima\dmwebplatform_git\DmWebPlatform.DataAccess\Migrations\20241007095912_InitialCreate.cs
	namespace 	
DmWebPlatform
 
. 

DataAccess "
." #

Migrations# -
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
$str 
, 
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
,A B
Category 
= 
table $
.$ %
Column% +
<+ ,
string, 2
>2 3
(3 4
type4 8
:8 9
$str: I
,I J
nullableK S
:S T
falseU Z
)Z [
,[ \
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 E
,E F
nullableG O
:O P
falseQ V
)V W
,W X
Images 
= 
table "
." #
Column# )
<) *
string* 0
>0 1
(1 2
type2 6
:6 7
$str8 G
,G H
nullableI Q
:Q R
falseS X
)X Y
,Y Z
Description 
=  !
table" '
.' (
Column( .
<. /
string/ 5
>5 6
(6 7
type7 ;
:; <
$str= L
,L M
nullableN V
:V W
falseX ]
)] ^
,^ _
Place 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 F
,F G
nullableH P
:P Q
falseR W
)W X
,X Y
Date 
= 
table  
.  !
Column! '
<' (
DateOnly( 0
>0 1
(1 2
type2 6
:6 7
$str8 >
,> ?
nullable@ H
:H I
falseJ O
)O P
,P Q
Time 
= 
table  
.  !
Column! '
<' (
TimeOnly( 0
>0 1
(1 2
type2 6
:6 7
$str8 >
,> ?
nullable@ H
:H I
falseJ O
)O P
,P Q
AdditionalInfo "
=# $
table% *
.* +
Column+ 1
<1 2
string2 8
>8 9
(9 :
type: >
:> ?
$str@ O
,O P
nullableQ Y
:Y Z
false[ `
)` a
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 0
,0 1
x2 3
=>4 6
x7 8
.8 9
Id9 ;
); <
;< =
}   
)   
;   
}!! 	
	protected$$ 
override$$ 
void$$ 
Down$$  $
($$$ %
MigrationBuilder$$% 5
migrationBuilder$$6 F
)$$F G
{%% 	
migrationBuilder&& 
.&& 
	DropTable&& &
(&&& '
name'' 
:'' 
$str'' 
)'' 
;''  
}(( 	
})) 
}** Œ
WC:\Users\Dima\dmwebplatform_git\DmWebPlatform.DataAccess\ApplicationDbContextFactory.cs
	namespace 	
DmWebPlatform
 
. 

DataAccess "
{ 
public 

class '
ApplicationDbContextFactory ,
:- .'
IDesignTimeDbContextFactory/ J
<J K 
ApplicationDbContextK _
>_ `
{ 
public		  
ApplicationDbContext		 #
CreateDbContext		$ 3
(		3 4
string		4 :
[		: ;
]		; <
args		= A
)		A B
{

 	
var 
basePath 
= 
	Directory $
.$ %
GetCurrentDirectory% 8
(8 9
)9 :
;: ;
var 
configuration 
= 
new  # 
ConfigurationBuilder$ 8
(8 9
)9 :
. 
SetBasePath 
( 
basePath %
)% &
. 
AddJsonFile 
( 
$str /
,/ 0
optional1 9
:9 :
false; @
,@ A
reloadOnChangeB P
:P Q
trueR V
)V W
. #
AddEnvironmentVariables (
(( )
)) *
. 
Build 
( 
) 
; 
var 
connectionString  
=! "
configuration# 0
.0 1
GetConnectionString1 D
(D E
$strE X
)X Y
;Y Z
var 
optionsBuilder 
=  
new! $#
DbContextOptionsBuilder% <
<< = 
ApplicationDbContext= Q
>Q R
(R S
)S T
;T U
optionsBuilder 
. 
UseSqlServer '
(' (
connectionString( 8
)8 9
;9 :
return 
new  
ApplicationDbContext +
(+ ,
optionsBuilder, :
.: ;
Options; B
)B C
;C D
} 	
} 
} ¹	
PC:\Users\Dima\dmwebplatform_git\DmWebPlatform.DataAccess\ApplicationDbContext.cs
	namespace 	
DmWebPlatform
 
. 

DataAccess "
{ 
public 

class  
ApplicationDbContext %
:& '
	DbContext( 1
{ 
public 
virtual 
DbSet 
< 
Event "
>" #
Events$ *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
public		  
ApplicationDbContext		 #
(		# $
DbContextOptions		$ 4
<		4 5 
ApplicationDbContext		5 I
>		I J
options		K R
)		R S
:		T U
base		V Z
(		Z [
options		[ b
)		b c
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
} 