//%attributes = {}
//
var $version : Integer
$version:=7
var $4dversion : Text
$4dversion:="1960"

var $features : Object
$features:=New object:C1471("launchActionFromTabBar"; True:C214)


var $schema : cs:C1710.Schema
$schema:=cs:C1710.Schema.new()

// App infos

var $target; $targets; $info; $product; $organization; $developer : cs:C1710.SchemaNode
$target:=ofType("string").setEnum(New collection:C1472("iOS"; "android"))
$targets:=oneOf(ofType("array").addItem($target); $target)

$info:=ofType("object")\
.addProperty("version"; ofType("integer").setComment("version of this schema"))\
.addProperty("ideVersion"; ofType("string").setComment("4D Version; ex 1960"))\
.addProperty("ideBuildVersion"; ofType("string").setComment("4D build version"))\
.addProperty("componentBuild"; ofType("string"))\
.addProperty("target"; $targets)\
.setComment("Mainly info about IDE which produce the file")
$schema.addProperty("info"; $info; True:C214)

$product:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("version"; ofType("string"))\
.addProperty("copyright"; ofType("string"))\
.addProperty("bundleIdentifier"; ofType("string"))\
.setComment("Info of mobile app")
$schema.addProperty("product"; $product; True:C214)

$organization:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("teamId"; ofType("string"))\
.addProperty("id"; ofType("string"))\
.setComment("Info of dev team (useful to sign and to identify app)")
$schema.addProperty("organization"; $organization; True:C214)

$developer:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("id"; ofType("string"))\
.setComment("Info of dev (useful to sign and put in generated source code)")
$schema.addProperty("developer"; $developer; True:C214)

// Theme

var $ui : cs:C1710.SchemaNode
$ui:=ofType("object")\
.addProperty("dominantColor"; ofType("string"))
// .addProperty("navigationTransition"; ofType("string"))
$schema.addProperty("ui"; $ui; True:C214)

// Data/Server

var $attributeBase; $attributeStorage; $attributeRelatedEntity; $attributeRelatedEntities; $attributeCalculated; $attributeAlias : cs:C1710.SchemaNode

var $attributeTypes; $valueTypes : Collection
$attributeTypes:=New collection:C1472("storage"; "relatedEntity"; "relatedEntities"; "calculated"; "alias")
$valueTypes:=New collection:C1472("number"; "string"; "date"; "image"; "object"; "bool")  // TODO to complete?

$attributeBase:=ofType("object")\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))
// .addProperty("kind"; ofType("string").setEnum($attributeTypes); True)\

$attributeStorage:=OB Copy:C1225($attributeBase)\
.addProperty("fieldNumber"; ofType("integer"); False:C215/*if true it failed*/)\
.addProperty("kind"; ofType("string").setEnum(New collection:C1472("storage"); True:C214))\
.addProperty("valueType"; ofType("string").setEnum($valueTypes); True:C214)\
.addProperty("fieldType"; ofType("integer"); True:C214)\
.addProperty("type"; ofType("integer"); True:C214)\
.addProperty("name"; ofType("string"); True:C214)

$attributeRelatedEntity:=OB Copy:C1225($attributeBase)\
.addProperty("kind"; ofType("string").setEnum(New collection:C1472("relatedEntity"); True:C214))\
.addProperty("relatedDataClass"; ofType("string"); True:C214)\
.addProperty("inverseName"; ofType("string"); True:C214)\
.addProperty("relatedTableNumber"; ofType("integer"); True:C214)

$attributeRelatedEntities:=OB Copy:C1225($attributeBase)\
.addProperty("kind"; ofType("string").setEnum(New collection:C1472("relatedEntities"); True:C214))\
.addProperty("relatedDataClass"; ofType("string"); True:C214)\
.addProperty("inverseName"; ofType("string"); True:C214)\
.addProperty("relatedTableNumber"; ofType("integer"); True:C214)\
.addProperty("isToMany"; ofType("boolean"); True:C214)
// .addProperty("relatedEntities"; ofType("string"); True)

$attributeCalculated:=OB Copy:C1225($attributeBase)\
.addProperty("kind"; ofType("string").setEnum(New collection:C1472("calculated"); True:C214))
$attributeAlias:=OB Copy:C1225($attributeBase)\
.addProperty("kind"; ofType("string").setEnum(New collection:C1472("alias"); True:C214))\
.addProperty("path"; ofType("string"); True:C214)

var $attributeNamePattern : Text
$attributeNamePattern:="[A-Za-z_][A-Za-z\\d_]*"  // CLEAN: to enchance?

// TODO manage recu
//$attributeRelatedEntity.addPatternProperty("[0-9]+"; oneOf(OB Copy($attributeRelatedEntity); OB Copy($attributeRelatedEntities); OB Copy($attributeCalculated); OB Copy($attributeAlias)))

var $entityInfo; $entity; $dataModel; $dataSource; $server : cs:C1710.SchemaNode
$entityInfo:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("primaryKey"; ofType("string"))\
.addProperty("embedded"; ofType("boolean"))
$entity:=ofType("object")\
.addProperty(""; $entityInfo; True:C214)\
.addPatternProperty("[0-9]+"; $attributeStorage)\
.addPatternProperty($attributeNamePattern; oneOf($attributeRelatedEntity; $attributeRelatedEntities; $attributeCalculated; $attributeAlias))

$dataModel:=ofType("object")\
.addPatternProperty("[0-9]+"; $entity)\
.setComment("Describe the entities and their attributed need by the app")
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

var $menuDefinition; $menuItem; $menuTableItem; $menuActionItem : cs:C1710.SchemaNode
$menuTableItem:=ofType("string").setComment("table number")/*TODO add number pattern*/
If (Bool:C1537($features.launchActionFromTabBar))
	
	$menuActionItem:=ofType("object")\
		.addProperty("name"; ofType("string"); True:C214)\
		.addProperty("label"; ofType("string"))\
		.addProperty("shortLabel"; ofType("string"))\
		.addProperty("icon"; ofType("string"))\
		.addProperty("actions"; ofType("array").addItem(ofType("string").setComment("action name")))
	
	$menuItem:=oneOf($menuTableItem; $menuActionItem)
Else 
	$menuItem:=$menuTableItem
End if 
$menuDefinition:=ofType("array").addItem($menuItem)

var $main : cs:C1710.SchemaNode
$main:=ofType("object")\
.addProperty("navigationTitle"; ofType("string"))\
.addProperty("navigationType"; ofType("string"))\
.addProperty("order"; $menuDefinition)\
.setComment("Describe the main menu")
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
.addPatternProperty("[0-9]+"; $formDefinition)\
.setComment("Define fields/attributes affected to list table forms by table")
$schema.addProperty("list"; $list; False:C215)

$detail:=ofType("object")\
.addPatternProperty("[0-9]+"; $formDefinition)\
.setComment("Define fields/attributes affected to detail table forms by table")
$schema.addProperty("detail"; $detail; False:C215)

// Actions
var $actionParameter; $action; $actions : cs:C1710.SchemaNode
$actionParameter:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("label"; ofType("string"))\
.addProperty("shortLabel"; ofType("string"))\
.addProperty("type"; ofType("string"); True:C214)

var $actionScopes : Collection
$actionScopes:=New collection:C1472("table"; "currentRecord")
If (Bool:C1537($features.launchActionFromTabBar))
	$actionScopes.push("global")
End if 

$action:=ofType("object")\
.addProperty("name"; ofType("string"); True:C214)\
.addProperty("scope"; ofType("string").setEnum($actionScopes); True:C214)\
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