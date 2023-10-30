Class {
	#name : #PhxVueVNodeDefinition,
	#superclass : #PjDomController,
	#instVars : [
		'tag',
		'definitionObject',
		'children'
	],
	#category : #'Phx-Pj-Vue-Core'
}

{ #category : #'instance creation' }
PhxVueVNodeDefinition class >> newWithTag: aTag [
	^ self new
		tag: aTag;
		initialize
]

{ #category : #private }
PhxVueVNodeDefinition >> addChild: aChild [
	children add: aChild
]

{ #category : #configuration }
PhxVueVNodeDefinition >> atSubDef: definitionAspect add: aStringOrArray [
	| subDef |
	subDef := definitionObject
		at: definitionAspect
		ifAbsentPut: Object new.
	aStringOrArray isString
		ifTrue: [ (' ' split: aStringOrArray)
				do: [ :each | subDef at: each put: true ] ]
		ifFalse: [ aStringOrArray
				do: [ :def | 
					def isString
						ifTrue: [ subDef at: def put: '' ]
						ifFalse: [ subDef at: def key put: def value ] ] ]
]

{ #category : #configuration }
PhxVueVNodeDefinition >> defAt: key put: aValue [
	definitionObject at: key put: aValue
]

{ #category : #private }
PhxVueVNodeDefinition >> evaluateWithCreateElementFunction: createElementFunction [
	"console log: 'rendering' with: tag with: definitionObject."

	"	console
		log: 'MAGIC: '
		with: 'tag/comp: '
		with: tag
		with: 'defObj: '
		with: definitionObject
		with: 'children: '
		with: children."

	^ createElementFunction
		  value: tag
		  value: definitionObject
		  value: { ('default' -> [ children ]) } asJsObject
]

{ #category : #'initialize-release' }
PhxVueVNodeDefinition >> initialize [
	super initialize.
	definitionObject := Object new.
	children := OrderedCollection new
]

{ #category : #accessing }
PhxVueVNodeDefinition >> tag [
	^ tag
]

{ #category : #accessing }
PhxVueVNodeDefinition >> tag: anObject [
	tag := anObject
]
