# JSON

some stuff for JSON

## Schema

### Builder

```4d
$schema:=cs.Schema.new()

$product:=ofType("object")\
.addProperty("name"; ofType("string"))\
.addProperty("version"; ofType("string"))\
.addProperty("copyright"; ofType("string"))\
.addProperty("bundleIdentifier"; ofType("string"))

$schema.addProperty("product"; $product; True:C214)

```

will be json stringifyed to

```json
{
	"$schema": "http://json-schema.org/draft-04/schema#",
	"type": "object",
	"properties": {
		"product": {
			"type": "object",
			"properties": {
				"name": {
					"type": "string"
				},
				"version": {
					"type": "string"
				},
				"copyright": {
					"type": "string"
				},
				"bundleIdentifier": {
					"type": "string"
				}
			}
		}
	},
	"required": [
		"product"
	]
}
```

full example [here for mobile app project](Project/Sources/Methods/test_projectMobile.4dm)

### Validate

```4d
$result:=JSON Validate($yourJSONObject; $schema)

// or

$result:=$schema.validate($yourJSONObject)
```
