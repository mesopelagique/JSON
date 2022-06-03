//%attributes = {}

var $schemaInfo : cs:C1710.Schema
$schemaInfo:=cs:C1710.Schema.new()

var $isMobileSession : Boolean
$isMobileSession:=True:C214  // produce a schema for mobile if true with "mobile" required, but a non session mobile could not have this property

var $mobile; $application; $team; $device; $language : cs:C1710.SchemaNode

$language:=ofType("object")\
.addProperty("id"; ofType("string"); True:C214)\
.addProperty("code"; ofType("string"); True:C214)\
.addProperty("region"; ofType("string"); True:C214)

$application:=ofType("object")\
.addProperty("id"; ofType("string"); True:C214)\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("version"; ofType("string"); True:C214)

$team:=ofType("object")\
.addProperty("id"; ofType("string"); True:C214)

$device:=ofType("object")\
.addProperty("id"; ofType("string"); True:C214)\
.addProperty("description"; ofType("string"); True:C214)\
.addProperty("version"; ofType("string"); True:C214)\
.addProperty("simulator"; ofType("boolean"))\
.addProperty("os"; ofType("string"); True:C214)

$mobile:=ofType("object")\
.addProperty("language"; $language; True:C214)\
.addProperty("email"; ofType("string"); True:C214)\
.addProperty("status"; ofType("string"); True:C214)\
.addProperty("token"; ofType("string"))\
.addProperty("parameters"; ofType("object"); True:C214)\
.addProperty("userInfo"; ofType("object"); True:C214)\
.addProperty("application"; $application; True:C214)\
.addProperty("team"; $team; True:C214)\
.addProperty("device"; $device; True:C214)\

$schemaInfo\
.addProperty("ip"; ofType("string"); True:C214)\
.addProperty("mobile"; $mobile; $isMobileSession)

//----

var $output : 4D:C1709.File
$output:=Folder:C1567(fk resources folder:K87:11).folder("test").file("session.info.schema.json")
$output.setText($schemaInfo.stringify(True:C214))

If (Shift down:C543)
	SHOW ON DISK:C922($output.platformPath)
End if 

