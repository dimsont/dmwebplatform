Õ
=C:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\SeedData.cs
	namespace 	
DmWebPlatform
 
. 
API 
{ 
public 

class 
SeedData 
{ 
public		 
static		 
async		 
Task		  

Initialize		! +
(		+ ,
IServiceProvider		, <
serviceProvider		= L
)		L M
{

 	
var 
roleManager 
= 
serviceProvider -
.- .
GetRequiredService. @
<@ A
RoleManagerA L
<L M
IdentityRoleM Y
>Y Z
>Z [
([ \
)\ ]
;] ^
var 
userManager 
= 
serviceProvider -
.- .
GetRequiredService. @
<@ A
UserManagerA L
<L M
ApplicationUserM \
>\ ]
>] ^
(^ _
)_ `
;` a
string 
[ 
] 
	roleNames 
=  
{! "
$str# *
,* +
$str, 8
,8 9
$str: @
,@ A
$strB I
}J K
;K L
foreach 
( 
var 
roleName !
in" $
	roleNames% .
). /
{ 
var 
	roleExist 
= 
await  %
roleManager& 1
.1 2
RoleExistsAsync2 A
(A B
roleNameB J
)J K
;K L
if 
( 
! 
	roleExist 
) 
{ 
await 
roleManager %
.% &
CreateAsync& 1
(1 2
new2 5
IdentityRole6 B
(B C
roleNameC K
)K L
)L M
;M N
} 
} 
var 
	adminUser 
= 
new 
ApplicationUser  /
{ 
UserName 
= 
$str -
,- .
Email 
= 
$str *
}   
;   
string"" 
adminPassword""  
=""! "
$str""# 6
;""6 7
var## 
existingAdminUser## !
=##" #
await##$ )
userManager##* 5
.##5 6
FindByEmailAsync##6 F
(##F G
	adminUser##G P
.##P Q
Email##Q V
)##V W
;##W X
if%% 
(%% 
existingAdminUser%% !
==%%" $
null%%% )
)%%) *
{&& 
var(( !
createAdminUserResult(( )
=((* +
await((, 1
userManager((2 =
.((= >
CreateAsync((> I
(((I J
	adminUser((J S
,((S T
adminPassword((U b
)((b c
;((c d
if)) 
()) !
createAdminUserResult)) )
.))) *
	Succeeded))* 3
)))3 4
{** 
await,, 
userManager,, %
.,,% &
AddToRoleAsync,,& 4
(,,4 5
	adminUser,,5 >
.,,> ?
Id,,? A
,,,A B
$str,,C J
),,J K
;,,K L
}-- 
}.. 
}// 	
}00 
}22 µf
<C:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
Log 
. 
Logger 

= 
new 
LoggerConfiguration $
($ %
)% &
. 
WriteTo 
. 
Console 
( 
) 
. 
CreateLogger 
( 
) 
; 
builder 
. 
Host 
. 

UseSerilog 
( 
) 
; 
var 
appSettings 
= 
new 
AppSettings !
(! "
)" #
;# $
builder 
. 
Configuration 
. 

GetSection  
(  !
$str! 4
)4 5
.5 6
Bind6 :
(: ;
appSettings; F
,F G
optionsH O
=>P R
optionsS Z
.Z [#
BindNonPublicProperties[ r
=s t
trueu y
)y z
;z {
builder   
.   
Services   
.   
AddAutoMapper   
(   
typeof   %
(  % &
MappingProfile  & 4
)  4 5
)  5 6
;  6 7
builder## 
.## 
Services## 
.## 
AddSingleton## 
<## 
IMongoClient## *
>##* +
(##+ ,
serviceProvider##, ;
=>##< >
{$$ 
var%% 
connectionString%% 
=%% 
builder%% "
.%%" #
Configuration%%# 0
[%%0 1
$str%%1 J
]%%J K
;%%K L
return&& 

new&& 
MongoClient&& 
(&& 
connectionString&& +
)&&+ ,
;&&, -
}'' 
)'' 
;'' 
builder(( 
.(( 
Services(( 
.(( 
	AddScoped(( 
<(( 
IMongoDatabase(( )
>(() *
(((* +
serviceProvider((+ :
=>((; =
{)) 
var** 
mongoClient** 
=** 
serviceProvider** %
.**% &
GetRequiredService**& 8
<**8 9
IMongoClient**9 E
>**E F
(**F G
)**G H
;**H I
var++ 
databaseName++ 
=++ 
builder++ 
.++ 
Configuration++ ,
[++, -
$str++- B
]++B C
;++C D
return,, 

mongoClient,, 
.,, 
GetDatabase,, "
(,," #
databaseName,,# /
),,/ 0
;,,0 1
}-- 
)-- 
;-- 
builder00 
.00 
Services00 
.00 
	AddScoped00 
<00 
IAuditLogService00 +
,00+ ,
AuditLogService00- <
>00< =
(00= >
)00> ?
;00? @
builder33 
.33 
Services33 
.33 
AddIdentity33 
<33 
ApplicationUser33 ,
,33, -
IdentityRole33. :
>33: ;
(33; <
)33< =
.44 $
AddEntityFrameworkStores44 
<44  
ApplicationDbContext44 2
>442 3
(443 4
)444 5
.55 $
AddDefaultTokenProviders55 
(55 
)55 
;55  
var88 
key88 
=88 	
Encoding88
 
.88 
ASCII88 
.88 
GetBytes88 !
(88! "
builder88" )
.88) *
Configuration88* 7
[887 8
$str888 A
]88A B
)88B C
;88C D
builder99 
.99 
Services99 
.99 
AddAuthentication99 "
(99" #
options99# *
=>99+ -
{:: 
options;; 
.;; %
DefaultAuthenticateScheme;; %
=;;& '
JwtBearerDefaults;;( 9
.;;9 : 
AuthenticationScheme;;: N
;;;N O
options<< 
.<< "
DefaultChallengeScheme<< "
=<<# $
JwtBearerDefaults<<% 6
.<<6 7 
AuthenticationScheme<<7 K
;<<K L
}== 
)== 
.>> 
AddJwtBearer>> 
(>> 
jwt>> 
=>>> 
{?? 
jwt@@ 
.@@ 
	SaveToken@@ 
=@@ 
true@@ 
;@@ 
jwtAA 
.AA %
TokenValidationParametersAA !
=AA" #
newAA$ '%
TokenValidationParametersAA( A
{BB $
ValidateIssuerSigningKeyCC  
=CC! "
trueCC# '
,CC' (
IssuerSigningKeyDD 
=DD 
newDD  
SymmetricSecurityKeyDD 3
(DD3 4
keyDD4 7
)DD7 8
,DD8 9
ValidateIssuerEE 
=EE 
falseEE 
,EE 
ValidateAudienceFF 
=FF 
falseFF  
,FF  !!
RequireExpirationTimeGG 
=GG 
trueGG  $
,GG$ %
ValidateLifetimeHH 
=HH 
trueHH 
,HH  
ValidIssuerII 
=II 
builderII 
.II 
ConfigurationII +
[II+ ,
$strII, 8
]II8 9
,II9 :
ValidAudienceJJ 
=JJ 
builderJJ 
.JJ  
ConfigurationJJ  -
[JJ- .
$strJJ. <
]JJ< =
}KK 
;KK 
}LL 
)LL 
;LL 
builderOO 
.OO 
ServicesOO 
.OO 
AddAuthorizationOO !
(OO! "
optionsOO" )
=>OO* ,
{PP 
optionsQQ 
.QQ 
	AddPolicyQQ 
(QQ 
$strQQ #
,QQ# $
policyQQ% +
=>QQ, .
policyQQ/ 5
.QQ5 6
RequireRoleQQ6 A
(QQA B
$strQQB I
)QQI J
)QQJ K
;QQK L
optionsRR 
.RR 
	AddPolicyRR 
(RR 
$strRR (
,RR( )
policyRR* 0
=>RR1 3
policyRR4 :
.RR: ;
RequireRoleRR; F
(RRF G
$strRRG S
)RRS T
)RRT U
;RRU V
optionsSS 
.SS 
	AddPolicySS 
(SS 
$strSS "
,SS" #
policySS$ *
=>SS+ -
policySS. 4
.SS4 5
RequireRoleSS5 @
(SS@ A
$strSSA G
)SSG H
)SSH I
;SSI J
optionsTT 
.TT 
	AddPolicyTT 
(TT 
$strTT #
,TT# $
policyTT% +
=>TT, .
policyTT/ 5
.TT5 6
RequireRoleTT6 A
(TTA B
$strTTB I
)TTI J
)TTJ K
;TTK L
}UU 
)UU 
;UU 
builderXX 
.XX 
ServicesXX 
.XX 
AddDatabaseXX 
(XX 
builderXX $
.XX$ %
ConfigurationXX% 2
)XX2 3
;XX3 4
builderYY 
.YY 
ServicesYY 
.YY 
AddHttpClientYY 
(YY 
)YY  
;YY  !
builderZZ 
.ZZ 
ServicesZZ 
.ZZ 
	AddScopedZZ 
<ZZ 
IEventServiceZZ (
,ZZ( )
EventServiceZZ* 6
>ZZ6 7
(ZZ7 8
)ZZ8 9
;ZZ9 :
builder[[ 
.[[ 
Services[[ 
.[[ 
AddControllers[[ 
([[  
)[[  !
;[[! "
builder^^ 
.^^ 
Services^^ 
.^^ #
AddEndpointsApiExplorer^^ (
(^^( )
)^^) *
;^^* +
builder__ 
.__ 
Services__ 
.__ 
AddSwaggerGen__ 
(__ 
)__  
;__  !
builderbb 
.bb 
Servicesbb 
.bb 
AddCorsbb 
(bb 
optionsbb  
=>bb! #
{cc 
optionsdd 
.dd 
	AddPolicydd 
(dd 
$strdd  
,dd  !
builderdd" )
=>dd* ,
{ee 
builderff 
.ff 
AllowAnyOriginff 
(ff 
)ff  
.gg 
AllowAnyMethodgg 
(gg 
)gg  
.hh 
AllowAnyHeaderhh 
(hh 
)hh  
;hh  !
}ii 
)ii 
;ii 
}jj 
)jj 
;jj 
buildermm 
.mm 
Servicesmm 
.mm 
AddHealthChecksmm  
(mm  !
)mm! "
;mm" #
varoo 
appoo 
=oo 	
builderoo
 
.oo 
Buildoo 
(oo 
)oo 
;oo 
usingrr 
(rr 
varrr 

scoperr 
=rr 
apprr 
.rr 
Servicesrr 
.rr  
CreateScoperr  +
(rr+ ,
)rr, -
)rr- .
{ss 
vartt 
servicestt 
=tt 
scopett 
.tt 
ServiceProvidertt (
;tt( )
tryuu 
{vv 
varww 
	dbContextww 
=ww 
servicesww  
.ww  !
GetRequiredServiceww! 3
<ww3 4 
ApplicationDbContextww4 H
>wwH I
(wwI J
)wwJ K
;wwK L
	dbContextxx 
.xx 
Databasexx 
.xx 
Migratexx "
(xx" #
)xx# $
;xx$ %
await{{ 
SeedData{{ 
.{{ 

Initialize{{ !
({{! "
services{{" *
){{* +
;{{+ ,
Log}} 
.}} 
Information}} 
(}} 
$str}} K
)}}K L
;}}L M
}~~ 
catch 	
(
 
	Exception 
ex 
) 
{
ÄÄ 
Log
ÅÅ 
.
ÅÅ 
Fatal
ÅÅ 
(
ÅÅ 
ex
ÅÅ 
,
ÅÅ 
$str
ÅÅ G
)
ÅÅG H
;
ÅÅH I
throw
ÇÇ 
;
ÇÇ 
}
ÉÉ 
}ÑÑ 
Logáá 
.
áá 
Logger
áá 

=
áá 
new
áá !
LoggerConfiguration
áá $
(
áá$ %
)
áá% &
.
àà 
ReadFrom
àà 
.
àà 
Configuration
àà 
(
àà 
builder
àà #
.
àà# $
Configuration
àà$ 1
)
àà1 2
.
ââ 
CreateLogger
ââ 
(
ââ 
)
ââ 
;
ââ 
ifåå 
(
åå 
app
åå 
.
åå 
Environment
åå 
.
åå 
IsDevelopment
åå !
(
åå! "
)
åå" #
)
åå# $
{çç 
app
éé 
.
éé '
UseDeveloperExceptionPage
éé !
(
éé! "
)
éé" #
;
éé# $
app
èè 
.
èè 

UseSwagger
èè 
(
èè 
)
èè 
;
èè 
app
êê 
.
êê 
UseSwaggerUI
êê 
(
êê 
)
êê 
;
êê 
}ëë 
elseíí 
{ìì 
app
îî 
.
îî !
UseExceptionHandler
îî 
(
îî 
$str
îî $
)
îî$ %
;
îî% &
app
ïï 
.
ïï 
UseHsts
ïï 
(
ïï 
)
ïï 
;
ïï 
}ññ 
appòò 
.
òò 
UseMiddleware
òò 
<
òò %
ErrorHandlingMiddleware
òò )
>
òò) *
(
òò* +
)
òò+ ,
;
òò, -
appöö 
.
öö !
UseHttpsRedirection
öö 
(
öö 
)
öö 
;
öö 
appúú 
.
úú 

UseRouting
úú 
(
úú 
)
úú 
;
úú 
appüü 
.
üü 
UseCors
üü 
(
üü 
$str
üü 
)
üü 
;
üü 
app¢¢ 
.
¢¢ 
UseAuthentication
¢¢ 
(
¢¢ 
)
¢¢ 
;
¢¢ 
app££ 
.
££ 
UseAuthorization
££ 
(
££ 
)
££ 
;
££ 
app¶¶ 
.
¶¶ 
MapHealthChecks
¶¶ 
(
¶¶ 
$str
¶¶ 
)
¶¶ 
;
¶¶ 
app©© 
.
©©  
MapControllerRoute
©© 
(
©© 
name
™™ 
:
™™ 	
$str
™™
 
,
™™ 
pattern
´´ 
:
´´ 
$str
´´ 7
)
´´7 8
;
´´8 9
app≠≠ 
.
≠≠ 
Run
≠≠ 
(
≠≠ 
)
≠≠ 	
;
≠≠	 
Ü
IC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Models\UserRoleModel.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Models "
{ 
public 

class 
UserRoleModel 
{ 
public 
string 
UserId 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
Role 
{ 
get  
;  !
set" %
;% &
}' (
public 
string 
UserName 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
}		 ˚
NC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Models\TokenResponseModel.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Models "
{ 
public 

class 
TokenResponseModel #
{ 
public 
string 
Token 
{ 
get !
;! "
set# &
;& '
}( )
public 
DateTime 

Expiration "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
}		 ¨
IC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Models\RegisterModel.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Models "
{ 
public 

class 
RegisterModel 
{ 
public 
string 
UserName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public		 
string		 
Password		 
{		  
get		! $
;		$ %
set		& )
;		) *
}		+ ,
public 
string 
ConfirmPassword %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
} 
} Í
FC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Models\LoginModel.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Models "
{ 
public 

class 

LoginModel 
{ 
public 
string 
UserName 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
}		 Ç
GC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Models\AppSettings.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Models "
{ 
public 

class 
AppSettings 
{ 
public 
static 
string 
DefaultConnection .
{/ 0
get1 4
;4 5
private6 =
set> A
;A B
}C D
} 
} Í
WC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Middleware\ErrorHandlingMiddleware.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 

Middleware &
{ 
public 

class #
ErrorHandlingMiddleware (
{ 
private 
readonly 
RequestDelegate (
_next) .
;. /
private		 
readonly		 
ILogger		  
<		  !#
ErrorHandlingMiddleware		! 8
>		8 9
_logger		: A
;		A B
public #
ErrorHandlingMiddleware &
(& '
RequestDelegate' 6
next7 ;
,; <
ILogger= D
<D E#
ErrorHandlingMiddlewareE \
>\ ]
logger^ d
)d e
{ 	
_next 
= 
next 
; 
_logger 
= 
logger 
; 
} 	
public 
async 
Task 
InvokeAsync %
(% &
HttpContext& 1
context2 9
)9 :
{ 	
try 
{ 
await 
_next 
( 
context #
)# $
;$ %
} 
catch 
( 
	Exception 
ex 
)  
{ 
_logger 
. 
LogError  
(  !
ex! #
,# $
$str% G
)G H
;H I
await  
HandleExceptionAsync *
(* +
context+ 2
)2 3
;3 4
} 
} 	
private 
Task  
HandleExceptionAsync )
() *
HttpContext* 5
context6 =
)= >
{ 	
context   
.   
Response   
.   

StatusCode   '
=  ( )
(  * +
int  + .
)  . /
HttpStatusCode  / =
.  = >
InternalServerError  > Q
;  Q R
context!! 
.!! 
Response!! 
.!! 
ContentType!! (
=!!) *
$str!!+ =
;!!= >
var## 
response## 
=## 
new## 
{##  
message##! (
=##) *
$str##+ ]
}##^ _
;##_ `
return$$ 
context$$ 
.$$ 
Response$$ #
.$$# $

WriteAsync$$$ .
($$. /
JsonConvert$$/ :
.$$: ;
SerializeObject$$; J
($$J K
response$$K S
)$$S T
)$$T U
;$$U V
}%% 	
}&& 
}'' ﬁ
[C:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Extensions\ServiceCollectionExtensions.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 

Extensions &
{ 
public		 

static		 
class		 '
ServiceCollectionExtensions		 3
{

 
public 
static 
IServiceCollection (
AddDatabase) 4
(4 5
this5 9
IServiceCollection: L
servicesM U
,U V
IConfigurationW e
configurationf s
)s t
{ 	
services 
. 
AddDbContext !
<! " 
ApplicationDbContext" 6
>6 7
(7 8
options8 ?
=>@ B
{ 
options 
. 
UseSqlServer $
($ %
AppSettings% 0
.0 1
DefaultConnection1 B
,B C

sqlOptions 
=> !

sqlOptions" ,
., -
CommandTimeout- ;
(; <
$num< ?
)? @
)@ A
;A B
options 
. !
UseLazyLoadingProxies -
(- .
). /
;/ 0
} 
) 
; 
services 
. 
	AddScoped 
< 
Func #
<# $ 
ApplicationDbContext$ 8
>8 9
>9 :
(: ;
(; <
provider< D
)D E
=>F H
(I J
)J K
=>L N
providerO W
.W X

GetServiceX b
<b c 
ApplicationDbContextc w
>w x
(x y
)y z
)z {
;{ |
services 
. 
	AddScoped 
< 
	DbFactory (
>( )
() *
)* +
;+ ,
services 
. 
	AddScoped 
< 
IUnitOfWork *
,* +

UnitOfWork, 6
>6 7
(7 8
)8 9
;9 :
return   
services   
;   
}!! 	
}"" 
}## °=
OC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Controllers\UserController.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Controllers '
{		 
[

 
Route

 

(


 
$str

 
)

 
]

 
[ 
ApiController 
] 
public 

class 
UserController 
:  !
ControllerBase" 0
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
readonly 
SignInManager &
<& '
ApplicationUser' 6
>6 7
_signInManager8 F
;F G
private 
readonly 
ITokenService &
_tokenService' 4
;4 5
private 
readonly 
RoleManager $
<$ %
IdentityRole% 1
>1 2
_roleManager3 ?
;? @
public 
UserController 
( 
UserManager 
< 
ApplicationUser '
>' (
userManager) 4
,4 5
SignInManager 
< 
ApplicationUser )
>) *
signInManager+ 8
,8 9
ITokenService 
tokenService &
,& '
RoleManager 
< 
IdentityRole $
>$ %
roleManager& 1
)1 2
{ 	
_userManager 
= 
userManager &
;& '
_signInManager 
= 
signInManager *
;* +
_tokenService 
= 
tokenService (
;( )
_roleManager 
= 
roleManager &
;& '
} 	
[   	
HttpPost  	 
(   
$str   
)   
]   
public!! 
async!! 
Task!! 
<!! 
IActionResult!! '
>!!' (
Register!!) 1
(!!1 2
[!!2 3
FromBody!!3 ;
]!!; <
RegisterModel!!= J
model!!K P
)!!P Q
{"" 	
var## 
user## 
=## 
new## 
ApplicationUser## *
{##+ ,
UserName##- 5
=##6 7
model##8 =
.##= >
UserName##> F
,##F G
Email##H M
=##N O
model##P U
.##U V
Email##V [
}##\ ]
;##] ^
var$$ 
result$$ 
=$$ 
await$$ 
_userManager$$ +
.$$+ ,
CreateAsync$$, 7
($$7 8
user$$8 <
,$$< =
model$$> C
.$$C D
Password$$D L
)$$L M
;$$M N
if&& 
(&& 
result&& 
.&& 
	Succeeded&&  
)&&  !
{'' 
await(( 
_userManager(( "
.((" #
AddToRoleAsync((# 1
(((1 2
user((2 6
,((6 7
$str((8 >
)((> ?
;((? @
var)) 
token)) 
=)) 
await)) !
_tokenService))" /
.))/ 0
GenerateToken))0 =
())= >
user))> B
)))B C
;))C D
return** 
Ok** 
(** 
new** 
{** 
Token**  %
=**& '
token**( -
}**. /
)**/ 0
;**0 1
}++ 
return-- 

BadRequest-- 
(-- 
result-- $
.--$ %
Errors--% +
)--+ ,
;--, -
}.. 	
[11 	
HttpPost11	 
(11 
$str11 
)11 
]11 
public22 
async22 
Task22 
<22 
IActionResult22 '
>22' (
Login22) .
(22. /
[22/ 0
FromBody220 8
]228 9

LoginModel22: D
model22E J
)22J K
{33 	
var44 
result44 
=44 
await44 
_signInManager44 -
.44- .
PasswordSignInAsync44. A
(44A B
model44B G
.44G H
UserName44H P
,44P Q
model44R W
.44W X
Password44X `
,44` a
isPersistent44b n
:44n o
false44p u
,44u v
lockoutOnFailure	44w á
:
44á à
false
44â é
)
44é è
;
44è ê
if55 
(55 
result55 
.55 
	Succeeded55  
)55  !
{66 
var77 
user77 
=77 
await77  
_userManager77! -
.77- .
FindByNameAsync77. =
(77= >
model77> C
.77C D
UserName77D L
)77L M
;77M N
var88 
token88 
=88 
await88 !
_tokenService88" /
.88/ 0
GenerateToken880 =
(88= >
user88> B
)88B C
;88C D
return99 
Ok99 
(99 
new99 
{99 
Token99  %
=99& '
token99( -
}99. /
)99/ 0
;990 1
}:: 
return<< 
Unauthorized<< 
(<<  
)<<  !
;<<! "
}== 	
[@@ 	
HttpGet@@	 
(@@ 
$str@@ 
)@@ 
]@@ 
[AA 	
	AuthorizeAA	 
(AA 
RolesAA 
=AA 
$strAA "
)AA" #
]AA# $
publicBB 
IActionResultBB 
GetRolesBB %
(BB% &
)BB& '
{CC 	
varDD 
rolesDD 
=DD 
_roleManagerDD $
.DD$ %
RolesDD% *
.DD* +
ToListDD+ 1
(DD1 2
)DD2 3
;DD3 4
returnEE 
OkEE 
(EE 
rolesEE 
)EE 
;EE 
}FF 	
[II 	
HttpPostII	 
(II 
$strII 
)II 
]II  
[JJ 	
	AuthorizeJJ	 
(JJ 
RolesJJ 
=JJ 
$strJJ "
)JJ" #
]JJ# $
publicKK 
asyncKK 
TaskKK 
<KK 
IActionResultKK '
>KK' (

AssignRoleKK) 3
(KK3 4
[KK4 5
FromBodyKK5 =
]KK= >
UserRoleModelKK? L
modelKKM R
)KKR S
{LL 	
varMM 
userMM 
=MM 
awaitMM 
_userManagerMM )
.MM) *
FindByNameAsyncMM* 9
(MM9 :
modelMM: ?
.MM? @
UserNameMM@ H
)MMH I
;MMI J
ifNN 
(NN 
userNN 
==NN 
nullNN 
)NN 
returnNN $
NotFoundNN% -
(NN- .
$strNN. >
)NN> ?
;NN? @
varPP 
resultPP 
=PP 
awaitPP 
_userManagerPP +
.PP+ ,
AddToRoleAsyncPP, :
(PP: ;
userPP; ?
,PP? @
modelPPA F
.PPF G
RolePPG K
)PPK L
;PPL M
ifQQ 
(QQ 
resultQQ 
.QQ 
	SucceededQQ  
)QQ  !
{RR 
returnSS 
OkSS 
(SS 
$strSS 6
)SS6 7
;SS7 8
}TT 
returnVV 

BadRequestVV 
(VV 
resultVV $
.VV$ %
ErrorsVV% +
)VV+ ,
;VV, -
}WW 	
}XX 
}YY âb
PC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Controllers\EventController.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Controllers '
{		 
[

 
ApiController

 
]

 
[ 
Route 

(
 
$str 
) 
] 
[ 
Produces 
( 
$str  
)  !
]! "
public 

class 
EventController  
:! "
ControllerBase# 1
{ 
private 
readonly 
IEventService &
_eventService' 4
;4 5
private 
readonly 
IAuditLogService )
_auditLogService* :
;: ;
public 
EventController 
( 
IEventService ,
eventService- 9
,9 :
IAuditLogService; K
auditLogServiceL [
)[ \
{ 	
_eventService 
= 
eventService (
;( )
_auditLogService 
= 
auditLogService .
;. /
} 	
[ 	
HttpGet	 
( 
Name 
= 
$str &
)& '
]' (
[ 	 
ProducesResponseType	 
( 
typeof $
($ %
IEnumerable% 0
<0 1
EventDto1 9
>9 :
): ;
,; <
StatusCodes= H
.H I
Status200OKI T
)T U
]U V
[ 	 
ProducesResponseType	 
( 
StatusCodes )
.) *
Status404NotFound* ;
); <
]< =
public 
async 
Task 
< 
ActionResult &
<& '
IEnumerable' 2
<2 3
EventDto3 ;
>; <
>< =
>= >
GetAllEvents? K
(K L
)L M
{ 	
try 
{ 
var   
events   
=   
await   "
_eventService  # 0
.  0 1
GetAll  1 7
(  7 8
)  8 9
;  9 :
return!! 
Ok!! 
(!! 
events!!  
)!!  !
;!!! "
}"" 
catch## 
(## 
	Exception## 
ex## 
)##  
{$$ 
return%% 
NotFound%% 
(%%  
ex%%  "
.%%" #
Message%%# *
)%%* +
;%%+ ,
}&& 
}'' 	
[** 	
HttpGet**	 
(** 
$str** 
,** 
Name** 
=** 
$str**  .
)**. /
]**/ 0
[++ 	 
ProducesResponseType++	 
(++ 
typeof++ $
(++$ %
EventDto++% -
)++- .
,++. /
StatusCodes++0 ;
.++; <
Status200OK++< G
)++G H
]++H I
[,, 	 
ProducesResponseType,,	 
(,, 
StatusCodes,, )
.,,) *
Status404NotFound,,* ;
),,; <
],,< =
public-- 
async-- 
Task-- 
<-- 
ActionResult-- &
<--& '
EventDto--' /
>--/ 0
>--0 1
GetEventById--2 >
(--> ?
int--? B
id--C E
)--E F
{.. 	
var// 
	eventItem// 
=// 
await// !
_eventService//" /
./// 0
GetOne//0 6
(//6 7
id//7 9
)//9 :
;//: ;
if11 
(11 
	eventItem11 
==11 
null11 !
)11! "
{22 
return33 
NotFound33 
(33  
)33  !
;33! "
}44 
return66 
Ok66 
(66 
	eventItem66 
)66  
;66  !
}77 	
[:: 	
	Authorize::	 
(:: 
Roles:: 
=:: 
$str:: "
)::" #
]::# $
[;; 	
HttpPost;;	 
(;; 
Name;; 
=;; 
$str;; &
);;& '
];;' (
[<< 	 
ProducesResponseType<<	 
(<< 
typeof<< $
(<<$ %
EventDto<<% -
)<<- .
,<<. /
StatusCodes<<0 ;
.<<; <
Status201Created<<< L
)<<L M
]<<M N
public== 
async== 
Task== 
<== 
ActionResult== &
<==& '
EventDto==' /
>==/ 0
>==0 1
CreateEvent==2 =
(=== >
EventDto==> F
item==G K
)==K L
{>> 	
await?? 
_eventService?? 
.??  
Add??  #
(??# $
item??$ (
)??( )
;??) *
varBB 
userIdBB 
=BB 
UserBB 
?BB 
.BB 
	FindFirstBB (
(BB( )

ClaimTypesBB) 3
.BB3 4
NameIdentifierBB4 B
)BBB C
?BBC D
.BBD E
ValueBBE J
??BBK M
$strBBN Y
;BBY Z
awaitCC 
_auditLogServiceCC "
.CC" #
LogActionAsyncCC# 1
(CC1 2
AuditActionTypeCC2 A
.CCA B
CreateEventCCB M
,CCM N
$"CCO Q
$strCCQ h
{CCh i
itemCCi m
.CCm n
IdCCn p
}CCp q
"CCq r
)CCr s
;CCs t
returnEE 
CreatedAtActionEE "
(EE" #
nameofEE# )
(EE) *
GetEventByIdEE* 6
)EE6 7
,EE7 8
newEE9 <
{EE= >
idEE? A
=EEB C
itemEED H
.EEH I
IdEEI K
}EEL M
,EEM N
itemEEO S
)EES T
;EET U
}FF 	
[II 	
	AuthorizeII	 
(II 
RolesII 
=II 
$strII "
)II" #
]II# $
[JJ 	
HttpPutJJ	 
(JJ 
$strJJ 
,JJ 
NameJJ 
=JJ 
$strJJ  -
)JJ- .
]JJ. /
[KK 	 
ProducesResponseTypeKK	 
(KK 
StatusCodesKK )
.KK) *
Status204NoContentKK* <
)KK< =
]KK= >
[LL 	 
ProducesResponseTypeLL	 
(LL 
StatusCodesLL )
.LL) *
Status400BadRequestLL* =
)LL= >
]LL> ?
publicMM 
asyncMM 
TaskMM 
<MM 
IActionResultMM '
>MM' (
UpdateEventMM) 4
(MM4 5
intMM5 8
idMM9 ;
,MM; <
EventDtoMM= E
itemMMF J
)MMJ K
{NN 	
ifOO 
(OO 
idOO 
!=OO 
itemOO 
.OO 
IdOO 
)OO 
{PP 
returnQQ 

BadRequestQQ !
(QQ! "
$strQQ" 5
)QQ5 6
;QQ6 7
}RR 
awaitTT 
_eventServiceTT 
.TT  
UpdateTT  &
(TT& '
itemTT' +
)TT+ ,
;TT, -
varWW 
userIdWW 
=WW 
UserWW 
?WW 
.WW 
	FindFirstWW (
(WW( )

ClaimTypesWW) 3
.WW3 4
NameIdentifierWW4 B
)WWB C
?WWC D
.WWD E
ValueWWE J
??WWK M
$strWWN Y
;WWY Z
awaitXX 
_auditLogServiceXX "
.XX" #
LogActionAsyncXX# 1
(XX1 2
AuditActionTypeXX2 A
.XXA B
UpdateEventXXB M
,XXM N
$"XXO Q
$strXXQ h
{XXh i
itemXXi m
.XXm n
IdXXn p
}XXp q
"XXq r
)XXr s
;XXs t
returnZZ 
	NoContentZZ 
(ZZ 
)ZZ 
;ZZ 
}[[ 	
[^^ 	
	Authorize^^	 
(^^ 
Roles^^ 
=^^ 
$str^^ "
)^^" #
]^^# $
[__ 	

HttpDelete__	 
(__ 
$str__ 
,__ 
Name__  
=__! "
$str__# 0
)__0 1
]__1 2
[`` 	 
ProducesResponseType``	 
(`` 
StatusCodes`` )
.``) *
Status204NoContent``* <
)``< =
]``= >
publicaa 
asyncaa 
Taskaa 
<aa 
IActionResultaa '
>aa' (
DeleteEventaa) 4
(aa4 5
intaa5 8
idaa9 ;
)aa; <
{bb 	
awaitcc 
_eventServicecc 
.cc  
Deletecc  &
(cc& '
idcc' )
)cc) *
;cc* +
varff 
userIdff 
=ff 
Userff 
?ff 
.ff 
	FindFirstff (
(ff( )

ClaimTypesff) 3
.ff3 4
NameIdentifierff4 B
)ffB C
?ffC D
.ffD E
ValueffE J
??ffK M
$strffN Y
;ffY Z
awaitgg 
_auditLogServicegg "
.gg" #
LogActionAsyncgg# 1
(gg1 2
AuditActionTypegg2 A
.ggA B
DeleteEventggB M
,ggM N
$"ggO Q
$strggQ h
{ggh i
idggi k
}ggk l
"ggl m
)ggm n
;ggn o
returnii 
	NoContentii 
(ii 
)ii 
;ii 
}jj 	
[mm 	
HttpGetmm	 
(mm 
$strmm 
)mm 
]mm 
[nn 	 
ProducesResponseTypenn	 
(nn 
typeofnn $
(nn$ %
IListnn% *
<nn* +
EventDtonn+ 3
>nn3 4
)nn4 5
,nn5 6
StatusCodesnn7 B
.nnB C
Status200OKnnC N
)nnN O
]nnO P
[oo 	 
ProducesResponseTypeoo	 
(oo 
StatusCodesoo )
.oo) *
Status400BadRequestoo* =
)oo= >
]oo> ?
[pp 	 
ProducesResponseTypepp	 
(pp 
StatusCodespp )
.pp) *
Status404NotFoundpp* ;
)pp; <
]pp< =
publicqq 
asyncqq 
Taskqq 
<qq 
ActionResultqq &
<qq& '
IListqq' ,
<qq, -
EventDtoqq- 5
>qq5 6
>qq6 7
>qq7 8
SearchEventsqq9 E
(qqE F
[qqF G
	FromQueryqqG P
]qqP Q
stringqqR X

searchTermqqY c
)qqc d
{rr 	
ifss 
(ss 
stringss 
.ss 
IsNullOrEmptyss $
(ss$ %

searchTermss% /
)ss/ 0
)ss0 1
{tt 
returnuu 

BadRequestuu !
(uu! "
$struu" @
)uu@ A
;uuA B
}vv 
varxx 
eventsxx 
=xx 
awaitxx 
_eventServicexx ,
.xx, -
SearchEventsAsyncxx- >
(xx> ?

searchTermxx? I
)xxI J
;xxJ K
ifzz 
(zz 
eventszz 
==zz 
nullzz 
||zz !
!zz" #
eventszz# )
.zz) *
Anyzz* -
(zz- .
)zz. /
)zz/ 0
{{{ 
return|| 
NotFound|| 
(||  
$str||  ;
)||; <
;||< =
}}} 
var
ÄÄ 
userId
ÄÄ 
=
ÄÄ 
User
ÄÄ 
?
ÄÄ 
.
ÄÄ 
	FindFirst
ÄÄ (
(
ÄÄ( )

ClaimTypes
ÄÄ) 3
.
ÄÄ3 4
NameIdentifier
ÄÄ4 B
)
ÄÄB C
?
ÄÄC D
.
ÄÄD E
Value
ÄÄE J
??
ÄÄK M
$str
ÄÄN Y
;
ÄÄY Z
await
ÅÅ 
_auditLogService
ÅÅ "
.
ÅÅ" #
LogActionAsync
ÅÅ# 1
(
ÅÅ1 2
AuditActionType
ÅÅ2 A
.
ÅÅA B
SearchEvent
ÅÅB M
,
ÅÅM N
$"
ÅÅO Q
$str
ÅÅQ p
{
ÅÅp q

searchTerm
ÅÅq {
}
ÅÅ{ |
"
ÅÅ| }
)
ÅÅ} ~
;
ÅÅ~ 
return
ÉÉ 
Ok
ÉÉ 
(
ÉÉ 
events
ÉÉ 
)
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
}
ÖÖ 
}ÜÜ ´
TC:\Users\Dima\dmwebplatform_git\DmWebPlatform.API\Controllers\AuditLogsController.cs
	namespace 	
DmWebPlatform
 
. 
API 
. 
Controllers '
{		 
[

 
ApiController

 
]

 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
AuditLogsController $
:% &
ControllerBase' 5
{ 
private 
readonly 
IAuditLogService )
_auditLogService* :
;: ;
private 
readonly 
IMapper  
_mapper! (
;( )
public 
AuditLogsController "
(" #
IAuditLogService# 3
auditLogService4 C
,C D
IMapperE L
mapperM S
)S T
{ 	
_auditLogService 
= 
auditLogService .
;. /
_mapper 
= 
mapper 
; 
} 	
[ 	
HttpGet	 
] 
public 
async 
Task 
< 
ActionResult &
<& '
IEnumerable' 2
<2 3
AuditLogDto3 >
>> ?
>? @
>@ A
GetAuditLogsB N
(N O
)O P
{ 	
var 
	auditLogs 
= 
await !
_auditLogService" 2
.2 3
GetAuditLogsAsync3 D
(D E
)E F
;F G
var 
auditLogDtos 
= 
_mapper &
.& '
Map' *
<* +
IEnumerable+ 6
<6 7
AuditLogDto7 B
>B C
>C D
(D E
	auditLogsE N
)N O
;O P
return 
Ok 
( 
auditLogDtos "
)" #
;# $
} 	
[ 	
HttpPost	 
] 
public   
async   
Task   
<   
IActionResult   '
>  ' (
CreateAuditLog  ) 7
(  7 8
[  8 9
FromBody  9 A
]  A B
AuditLogDto  C N
auditLogDto  O Z
)  Z [
{!! 	
var## 
auditLogEntry## 
=## 
_mapper##  '
.##' (
Map##( +
<##+ ,
AuditLogEntry##, 9
>##9 :
(##: ;
auditLogDto##; F
)##F G
;##G H
var$$ 

actionType$$ 
=$$ 
($$ 
AuditActionType$$ -
)$$- .
Enum$$. 2
.$$2 3
Parse$$3 8
($$8 9
typeof$$9 ?
($$? @
AuditActionType$$@ O
)$$O P
,$$P Q
auditLogEntry$$R _
.$$_ `
Action$$` f
)$$f g
;$$g h
await%% 
_auditLogService%% "
.%%" #
LogActionAsync%%# 1
(%%1 2

actionType%%2 <
,%%< =
auditLogEntry%%> K
.%%K L
Payload%%L S
)%%S T
;%%T U
return'' 
Ok'' 
('' 
)'' 
;'' 
}(( 	
})) 
}** 