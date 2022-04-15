Class extends SchemaNode

Class constructor
	This:C1470.$schema:="http://json-schema.org/draft-04/schema#"
	
Function load($obj : Object)
	If (OB Instance of:C1731($obj; 4D:C1709.File))
		This:C1470.load(JSON Parse:C1218($obj.getText()))
	Else 
		var $key : Text
		For each ($key; $obj)
			This:C1470[$key]:=$obj[$key]
		End for each 
	End if 
	
	// Export to string
Function stringify($prettify : Boolean)->$jsonString : Text
	If (Bool:C1537($prettify))
		$jsonString:=JSON Stringify:C1217(This:C1470; *)
	Else 
		$jsonString:=JSON Stringify:C1217(This:C1470)
	End if 
	
	// Validate a json object
Function validate($obj : Object)->$result : Object
	If (OB Instance of:C1731($obj; 4D:C1709.File))
		$result:=This:C1470.validate(JSON Parse:C1218($obj.getText()))
	Else 
		$result:=JSON Validate:C1456($obj; This:C1470)
	End if 