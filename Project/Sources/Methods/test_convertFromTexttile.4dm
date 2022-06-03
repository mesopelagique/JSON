//%attributes = {}

var $textTile; $line; $part; $type; $name : Text
var $lines; $parts; $currents : Collection
var $schema : cs:C1710.Schema
var $node : cs:C1710.SchemaNode
var $index; $currentIndex : Integer
var $types : Object

$textTile:="|id|||| Text |Session UUID|\n|info|||| Object |Session info|\n||ip||| Text |Client IP address|\n||mobile||| Object |Information about the mobile user|\n|||language ||Object|Language settings of the user device|\n||||id|Text|User device current language id|"+"\n||||code|Text|User device current language code|\n||||region|Text|User device current language region|\n|||email|| Text |User email. Not mandatory, can be empty for guest access|\n|||status|| Text |Session status. Accepted or pending |\n|||token|| Text |"+"User token|\n|||parameters|| Object |Any additional information that could be added by the mobile app native code for custom use|\n|||userInfo|| Object |Additional information to base a filter query on (added by 4D code in `On Mobile App Authentication`"+")|\n|||application|| Object |Information about the mobile application|\n||||id| Text |Mobile application id|\n||||name| Text |Mobile application name|\n||||version| Text |Mobile application version|\n|||team|| Object |Apple Developer Team information|\n||||"+"id| Text |Team id|\n|||device|| Object |Information about the mobile device|\n||||description| Text |Description of the device|\n||||version| Text |System version of the device|\n||||id| Text |Generated unique device id|\n||||simulator| Boolean |True if th"+"e device is a simulator|\n||||os| Text |User device OS|"

$lines:=Split string:C1554($textTile; "\n")

$schema:=cs:C1710.Schema.new()


$currents:=New collection:C1472()
$currents.push($schema)

$types:=New object:C1471(\
"Text"; "string"; \
"Object"; "object"; \
"Boolean"; "boolean")  // XXX add other types

$currentIndex:=0

var $trim : 4D:C1709.Function
$trim:=Formula:C1597(Split string:C1554($1; " ").join(""))  // XXX do not remove space inside

For each ($line; $lines)
	$parts:=Split string:C1554($line; "|")
	
	$index:=0
	For each ($part; $parts) Until (Length:C16($name)>0)
		$name:=$part
		$index+=1
	End for each 
	$name:=$trim.call(Null:C1517; $name)
	
	If ($index<$currentIndex)
		$currents.pop()
	End if 
	$currentIndex:=$index
	
	For each ($part; $parts; $index) Until (Length:C16($type)>0)
		$type:=$part
		$index+=1
	End for each 
	
	$comment:=""
	For each ($part; $parts; $index)
		$comment+=$part
	End for each 
	
	$type:=$types[$trim.call(Null:C1517; $type)]
	$node:=ofType($type).setComment($comment)
	
	$currents[$currents.length-1].addProperty($name; $node)
	
	If ($type="object")
		$currents.push($node)
	End if 
	
End for each 

// --
var $output : 4D:C1709.File
$output:=Folder:C1567(fk resources folder:K87:11).folder("test").file("session.schema.json")
$output.setText($schema.stringify(True:C214))

If (Shift down:C543)
	SHOW ON DISK:C922($output.platformPath)
End if 
