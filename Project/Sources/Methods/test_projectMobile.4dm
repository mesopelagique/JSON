//%attributes = {}



var $schema : cs:C1710.Schema
$schema:=cs:C1710.Schema.new()

// App infos

var $target; $info; $product; $organization; $developer : cs:C1710.SchemaNode

$target:=anyOf(ofType("array").addItem(ofType("string")); ofType("string"))  // object too?

$info:=ofType("object")\
.addProperty("version"; ofType("integer"))\
.addProperty("ideVersion"; ofType("string"))\
.addProperty("ideBuildVersion"; ofType("string"))\
.addProperty("componentBuild"; ofType("string"))\
.addProperty("target"; $target)
$schema.addProperty("info"; $info; True:C214)

$product:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("version"; ofType("string"))\
.addProperty("copyright"; ofType("string"))\
.addProperty("bundleIdentifier"; ofType("string"))
$schema.addProperty("product"; $product; True:C214)

$organization:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("teamId"; ofType("string"))\
.addProperty("id"; ofType("string"))
$schema.addProperty("organization"; $organization; True:C214)

$developer:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("id"; ofType("string"))
$schema.addProperty("developer"; $developer; True:C214)

// Theme

var $ui : cs:C1710.SchemaNode
$ui:=ofType("object")\
.addProperty("dominantColor"; ofType("string"))
// .addProperty("navigationTransition"; ofType("string"))
$schema.addProperty("ui"; $ui; True:C214)

// Data/Server

var $attribute; $entityInfo; $entity; $dataModel; $dataSource; $server : cs:C1710.SchemaNode
$attribute:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("fieldNumber"; ofType("integer"))\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("kind"; ofType("string"))\
.addProperty("fieldType"; ofType("integer"))\
.addProperty("valueType"; ofType("string"))\
.addProperty("type"; ofType("integer"))

$entityInfo:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("primaryKey"; ofType("string"))\
.addProperty("embedded"; ofType("boolean"))
$entity:=ofType("object")\
.addProperty(""; $entityInfo; True:C214)
$dataModel:=ofType("object")\
.addPatternProperty("[0-9]+"; $entity)
$schema.addProperty("dataModel"; $dataModel; True:C214)

$dataSource:=ofType("object")\
.addProperty("source"; ofType("string"))\
.addProperty("doNotGenerateDataAtEachBuild"; ofType("boolean"))\
.addProperty("doNotExportImages"; ofType("boolean"))
$schema.addProperty("dataSource"; $dataSource; True:C214)

$server:=ofType("object")\
.addProperty("urls"; ofType("object").addProperty("production"; ofType("string")))
$schema.addProperty("server"; $server; True:C214)

// Navigation/Main form

var $main : cs:C1710.SchemaNode
$main:=ofType("object")\
.addProperty("navigationTitle"; ofType("string"))\
.addProperty("navigationType"; ofType("string"))\
.addProperty("order"; ofType("array").addItem(ofType("string")))
$schema.addProperty("main"; $main; True:C214)

// The forms: if not filled, will use default form

var $formField; $formDefinition; $list; $detail : cs:C1710.SchemaNode
$formField:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("kind"; ofType("string"); True:C214)\
.addProperty("fieldType"; ofType("integer"); True:C214)\
.addProperty("fieldNumber"; ofType("integer"); False:C215)\
.addProperty("path"; ofType("string"); False:C215)

$formDefinition:=ofType("object")\
.addProperty("form"; ofType("string"))\
.addProperty("fields"; ofType("array").addItem($formField))

$list:=ofType("object")\
.addPatternProperty("[0-9]+"; $formDefinition)
$schema.addProperty("list"; $list; False:C215)

$detail:=ofType("object")\
.addPatternProperty("[0-9]+"; $formDefinition)
$schema.addProperty("detail"; $detail; False:C215)

// Actions
var $actionParameter; $action; $actions : cs:C1710.SchemaNode
$actionParameter:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("type"; ofType("string"); True:C214)

$action:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("scope"; ofType("string"); True:C214)\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("icon"; ofType("string"))\
.addProperty("tableNumber"; ofType("integer"))\
.addProperty("parameters"; ofType("array").addItem($actionParameter))

$actions:=ofType("array")\
.addItem($action)
$schema.addProperty("actions"; $actions; False:C215)

//----

var $output : 4D:C1709.File
$output:=Folder:C1567(fk resources folder:K87:11).folder("test").file("4dmobileapp.schema.json")
$output.setText($schema.stringify(True:C214))

If (Shift down:C543)
	SHOW ON DISK:C922($output.platformPath)
End if 

var $validation : Object
$validation:=$schema.validate(Folder:C1567(fk resources folder:K87:11).folder("test").file("project.4dmobileapp"))
ASSERT:C1129($validation.success; JSON Stringify:C1217($validation))