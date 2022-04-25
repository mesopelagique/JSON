# entity root

## scalaire/storage

### champs d'entité

```json
	"dataModel": {
		"5": {
			"2": {
				"name": "Alpha Field",
				"kind": "storage",
				"fieldType": 0,
				"label": "Alpha Field",
				"shortLabel": "Alpha Field",
				"valueType": "string",
				"type": 10
			}
```
  
### champs calculé
  
```json
	"dataModel": {
		"5": {
			"calc_alpha": {
				"kind": "calculated",
				"name": "calc_alpha",
				"label": "Calc Alpha",
				"shortLabel": "Calc Alpha",
				"fieldType": 2,
				"valueType": "string",
				"computed": true,
				"type": -3
			}
```

### champs alias

```json
	"dataModel": {
		"5": {
			"aka_identifiant": {
				"kind": "alias",
				"fieldType": 9,
				"path": "ID",
				"label": "Aka Identifiant",
				"shortLabel": "Aka Identifiant"
			}
```

## relation 1>N

### 1>N standard

```json
	"dataModel": {
		"6": {
			"subordinates": {
				"kind": "relatedEntities",
				"label": "List of Subordinates",
				"shortLabel": "Subordinates",
				"relatedEntities": "Employes",
				"inverseName": "manager",
				"relatedDataClass": "Employes",
				"relatedTableNumber": 6,
				"isToMany": true
			}
```

### alias sur 1>N

```json	
	"dataModel": {
		"6": {
			"nPlus1": {
				"kind": "alias",
				"fieldType": 38,
				"path": "manager",
				"label": "N Plus1",
				"shortLabel": "N Plus1"
			}
```


### computed sur 1>N

```diff
+ non supporté
```

# Entity lvl1 

on ouvre l'interface d'une relation N>1

## relation N>1 standards

## scalaire sous relation

```json
	"dataModel": {
		"6": {
			"manager": {
				"kind": "relatedEntity",
				"relatedDataClass": "Employes",
				"relatedTableNumber": 6,
				"inverseName": "subordinates",
				"2": {
					"name": "Name",
					"kind": "storage",
					"fieldType": 2,
					"valueType": "string",
					"label": "Name",
					"shortLabel": "Name",
					"type": 10
				}
			}
```

### computed scalaire sous relation N>1

```json
	"dataModel": {
		"6": {
			"manager": {
				"kind": "relatedEntity",
				"relatedDataClass": "Employes",
				"relatedTableNumber": 6,
				"inverseName": "subordinates",
				"computedName": {
					"kind": "calculated",
					"fieldType": 2,
					"valueType": "string",
					"label": "Computed Name",
					"shortLabel": "Computed N",
					"computed": true
				}
			}
```
 
### alias scalaire sous relation N>1

```diff
- pas clicable actuellement main 278715
```

### relation 1>N sour relation N>1

```json
	"dataModel": {
		"6": {
			"": {
				"name": "Employes",
				"label": "Employes",
				"shortLabel": "Employes",
				"primaryKey": "ID",
				"embedded": true
			},
			"manager": {
				"kind": "relatedEntity",
				"relatedDataClass": "Employes",
				"relatedTableNumber": 6,
				"inverseName": "subordinates",
				"subordinates": {
					"kind": "relatedEntities",
					"relatedDataClass": "Employes",
					"relatedTableNumber": 6,
					"inverseName": "manager",
					"path": "manager.subordinates",
					"label": "List of Subordinates",
					"shortLabel": "Subordinates",
					"isToMany": true
				}
			}
		}
```

### relation N>1 sour relation N>1

```diff
- ne devrait pas être dispo , une relation N>1 marche que si on peut cliquer et prendre les champs dedans actuellement
- main 278715
```


### alias scalaire sous une relation N>1

Dans Service 
```4d
exposed Alias aka_BigBossName manager.manager.Name
```
on coche dans manager service.aka_BigBossName
```json
	"dataModel": {
		"7": {
			"": {
				"name": "Service",
				"label": "Service",
				"shortLabel": "Service",
				"primaryKey": "ID",
				"embedded": true
			},
			"manager": {
				"kind": "relatedEntity",
				"relatedDataClass": "Employes",
				"relatedTableNumber": 6,
				"inverseName": "serviceManaged",
				"service": {
					"kind": "relatedEntity",
					"inverseName": "serviceManaged",
					"relatedTableNumber": 6,
					"aka_BigBossName": {
						"kind": "alias",
						"fieldType": 2,
						"path": "manager.manager.Name",
						"label": "Aka big Boss Name",
						"shortLabel": "Aka big Boss Name"
					}
				}
			}
		}
	},
```

```diff
+ "path": "manager.manager.Name"  c'est ok pour l'alias relativement à service
+ du point de vue de la table service on est dans un path manager.service.manager.manager.Name
```
