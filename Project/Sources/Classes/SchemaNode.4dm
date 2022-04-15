
// MARK: setter
Function setEnum($enum : Collection)->$this : cs:C1710.SchemaNode
	This:C1470.enum:=$enum  // CLEAN: check if all element are correct?
	$this:=This:C1470
	
Function setConst($value : Variant)->$this : cs:C1710.SchemaNode
	This:C1470.const:=$value  // CLEAN: check if $value are correct
	$this:=This:C1470
	
Function setComment($comment : Text)->$this : cs:C1710.SchemaNode
	This:C1470.$comment:=$comment
	$this:=This:C1470
	
	
Function ofType($type : Text)->$this : cs:C1710.SchemaNode
	This:C1470.type:=$type
	$this:=This:C1470
	
	// MARK: object
	
	// http://json-schema.org/understanding-json-schema/reference/object.html#properties
Function addProperty($property : Text; $node : cs:C1710.SchemaNode; $required : Boolean)->$this : cs:C1710.SchemaNode
	If (This:C1470.type=Null:C1517)
		This:C1470.type:="object"  // or assert?
	Else 
		ASSERT:C1129(This:C1470.type="object"; "property only for object")
	End if 
	If (This:C1470.properties=Null:C1517)
		This:C1470.properties:=New object:C1471
	End if 
	This:C1470.properties[$property]:=$node
	
	If ($required)
		This:C1470.setRequired($property)
	End if 
	
	$this:=This:C1470
	
	// http://json-schema.org/understanding-json-schema/reference/object.html#pattern-properties
Function addPatternProperty($pattern : Text; $node : cs:C1710.SchemaNode)->$this : cs:C1710.SchemaNode
	If (This:C1470.type=Null:C1517)
		This:C1470.type:="object"  // or assert?
	Else 
		ASSERT:C1129(This:C1470.type="object"; "PatternProperty only for object")
	End if 
	If (This:C1470.patternProperties=Null:C1517)
		This:C1470.patternProperties:=New object:C1471
	End if 
	This:C1470.patternProperties[$pattern]:=$node
	
	$this:=This:C1470
	
	// http://json-schema.org/understanding-json-schema/reference/object.html#additional-properties
Function setAdditionalProperties($value : Variant)->$this : cs:C1710.SchemaNode
	This:C1470.additionalProperties:=$value
	$this:=This:C1470
	
Function setRequired($property : Text)->$this : cs:C1710.SchemaNode
	If (This:C1470.type=Null:C1517)
		This:C1470.type:="object"  // or assert?
	Else 
		ASSERT:C1129(This:C1470.type="object"; "required only for object")
	End if 
	If (This:C1470.required=Null:C1517)
		This:C1470.required:=New collection:C1472
	End if 
	This:C1470.required.push($property)  // maybe check before if already in
	$this:=This:C1470
	
	// MARK: array
	
Function addItem($node : cs:C1710.SchemaNode)->$this : cs:C1710.SchemaNode
	If (This:C1470.type=Null:C1517)
		This:C1470.type:="array"  // or assert?
	Else 
		ASSERT:C1129(This:C1470.type="array"; "item only for object")
	End if 
	
	Case of 
		: (This:C1470.items=Null:C1517)
			This:C1470.items:=$node
		: (Value type:C1509(This:C1470.items)=Is collection:K8:32)
			This:C1470.items.push($node)
		: (Value type:C1509(This:C1470.items)=Is object:K8:27)
			This:C1470.items:=New collection:C1472(This:C1470.items; $node)
	End case 
	
	$this:=This:C1470
	