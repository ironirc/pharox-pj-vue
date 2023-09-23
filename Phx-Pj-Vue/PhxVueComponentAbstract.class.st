Class {
	#name : #PhxVueComponentAbstract,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait',
	#instVars : [
		'vueInstance',
		'props',
		'context',
		'reactiveState',
		'showPicker'
	],
	#classInstVars : [
		'componentDefinition'
	],
	#category : #'Phx-Pj-Vue-Core'
}

{ #category : #'initialize-release' }
PhxVueComponentAbstract class >> componentDefinition [
	"https://composition-api.vuejs.org/#summary"

	"https://composition-api.vuejs.org/api.html#setup"

	"<javascript: 'return {setup: function(props,context){console.log(props)}}'>"

	componentDefinition ifNil: [
		| cd |
		cd := {
			      ('name' -> self name).
			      ('props' -> self props).
			      ('setup' -> [ :props :context |
			       | comp |
			       console
				       log: 'Setting up '
				       with: self name
				       with: ' props: '
				       with: props.
			       "console log: 'ROUTE ***' with: global useRoute."
			       comp := self newWithProps: props context: context.
			       comp setupReactivity.
			       comp vueInstance:
				       (globalThis at: 'VueCompositionAPI') getCurrentInstance.
			       comp renderBlock "returning renderBlock as last" ]) }
			      asJsObject.
		componentDefinition := cd ].
	^ componentDefinition
]

{ #category : #'initialize-release' }
PhxVueComponentAbstract class >> newWithProps: props context: context [
	| comp |
	comp := self new.
	comp props: props.
	comp context: context.
	"console
		log: 'New ' , self class name
		with: comp
		with: 'props: '
		with: props
		with: 'context: '
		with: context."
	^ comp
]

{ #category : #'initialize-release' }
PhxVueComponentAbstract class >> props [
	^Object new
]

{ #category : #accessing }
PhxVueComponentAbstract >> context [
	^ context
]

{ #category : #accessing }
PhxVueComponentAbstract >> context: anObject [
	context := anObject
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> emit: anEventType with: aValue [
	<javascript: 'this.context.emit(anEventType,aValue)'>
]

{ #category : #'initialize-release' }
PhxVueComponentAbstract >> initialize [
	super initialize.
	reactiveState := Object new.
	
	
]

{ #category : #accessing }
PhxVueComponentAbstract >> props [
	^ props
]

{ #category : #accessing }
PhxVueComponentAbstract >> props: anObject [
	props := anObject
]

{ #category : #'initialize-release' }
PhxVueComponentAbstract >> renderBlock [
	^ [ | x |
	x := PhxVueVNodeBuilder newOnH: self vcApiH.
	x currentComponent: self.
	self renderVueWith: x.
	x vNode ]
]

{ #category : #rendering }
PhxVueComponentAbstract >> renderVueWith: x [
	self subclassResponsibility 
]

{ #category : #rendering }
PhxVueComponentAbstract >> rsAt: aSymbol [
	| result |
	result := reactiveState at: aSymbol.
	"console
		log: 'rsAt: '
		with: aSymbol
		with: ' comp: '
		with: self."
	^ result
]

{ #category : #rendering }
PhxVueComponentAbstract >> rsAt: aSymbol put: aValue [
"	console
		log: 'rsAt: '
		with: aSymbol
		with: ' put: '
		with: aValue
		with: ' comp: '
		with: self."
	"aValue
		ifNotNil: [
			aValue isString
				ifFalse: [ self halt ] ]."
	reactiveState at: aSymbol put: aValue
]

{ #category : #'initialize-release' }
PhxVueComponentAbstract >> setupReactivity [
	reactiveState := self vcApiReactive: reactiveState.
	"console log: 'ROOT = ' with: self thisContextRoot with: 'on:' with:  self"
"console
						log: 'self&this at' , self class name
						with: self
						with: self vueInstance "
	
	
]

{ #category : #vue }
PhxVueComponentAbstract >> thisContextRoot [
	<javascript: 'return this.context.root;'>
	
]

{ #category : #'as yet unclassified' }
PhxVueComponentAbstract >> thisContextRootProvided [
	<javascript: 'return this.context.root._provided;'>
	
]

{ #category : #vue }
PhxVueComponentAbstract >> thisContextRootRouter [
	<javascript: 'return this.context.root.$router;'>
	
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiH [

	^ (globalThis at: 'VueCompositionAPI') at: 'h'
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiInject [

	^ (globalThis at: 'VueCompositionAPI') at: 'inject'
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiMarkRaw: anObject [

	^ ((globalThis at: 'VueCompositionAPI') at: 'markRaw') value:
		  anObject
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiOnActivated: aBlock [

	^ ((globalThis at: 'VueCompositionAPI') at: 'onActivated') value:
		  aBlock
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiOnBeforeMount: aBlock [

	^ ((globalThis at: 'VueCompositionAPI') at: 'onBeforeMount') value:
		  aBlock
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiOnMounted: aBlock [

	^ ((globalThis at: 'VueCompositionAPI') at: 'onMounted') value:
		  aBlock
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiOnUpdated: aBlock [

	^ ((globalThis at: 'VueCompositionAPI') at: 'onUpdated') value:
		  aBlock
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiProvide [

	^ (globalThis at: 'VueCompositionAPI') at: 'provide'
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiReactive: anObject [

	^ ((globalThis at: 'VueCompositionAPI') at: 'reactive') value:
		  anObject
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiRef: anObject [

	^ ((globalThis at: 'VueCompositionAPI') at: 'ref') value: anObject
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiUnref: anObject [

	^ ((globalThis at: 'VueCompositionAPI') at: 'unref') value: anObject
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiWatch [

	^ (globalThis at: 'VueCompositionAPI') at: 'watch'
]

{ #category : #'vue composition api' }
PhxVueComponentAbstract >> vcApiWatchEffect [

	^ (globalThis at: 'VueCompositionAPI') at: 'watchEffect'
]

{ #category : #accessing }
PhxVueComponentAbstract >> vueInstance [
	^ vueInstance
]

{ #category : #accessing }
PhxVueComponentAbstract >> vueInstance: anObject [
	vueInstance := anObject
]
