Class {
	#name : #PhxVueComponentAbstract,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait + PhxVue3Trait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxVue3Trait classTrait',
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
			       "comp vueInstance:
				       (globalThis at: 'VueCompositionAPI') getCurrentInstance."
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

{ #category : #'vue traits' }
PhxVueComponentAbstract >> console [
	^ self explicitRequirement
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

{ #category : #'vue traits' }
PhxVueComponentAbstract >> h [
	^ (self vue at: 'h')
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
	x := PhxVueVNodeBuilder newOnH: self h.
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
	reactiveState := self vueReactive: reactiveState.
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

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vue [

	^ globalThis at: 'Vue'
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueComputed: aBlock [
	^ (self vue at: 'computed') value: aBlock
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueGetCurrentScope [
	^ (self vue at: #vueGetCurrentScope) value
]

{ #category : #accessing }
PhxVueComponentAbstract >> vueInstance [
	^ vueInstance
]

{ #category : #accessing }
PhxVueComponentAbstract >> vueInstance: anObject [
	vueInstance := anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueIsProxy: anObject [
"Checks if an object is a proxy created by reactive or readonly"
	^ (self vue at: 'isProxy') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueIsReactive: anObject [
"Checks if an object is a reactive proxy created by reactive"
	^ (self vue at: 'isReactive') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueIsReadonly: anObject [
"Checks if an object is a readonly proxy created by readonly"
	^ (self vue at: 'isReadonly') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueIsRef: anObject [
"Checks if an object is a reactive proxy created by reactive"
	^ (self vue at: 'isRef') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueMarkRaw: anObject [
"Marks an object so that it will never be converted to a proxy. Returns the object itself.
See also: https://v3.vuejs.org/api/basic-reactivity.html#markraw"
	^ (self vue at: 'markRaw') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueNewEffectScopeDetached [
	^self vueNewEffectScopeDetached: true
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueNewEffectScopeDetached: aBoolean [
	"self
		log:
			{'vueNewEffectScopeDetached:'.
			aBoolean}."
	^ (self vue at: 'effectScope') value: aBoolean
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueNewEffectScopeNonDetached [
	^ self vueNewEffectScopeDetached: false
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueReactive: anObject [
	^ (self vue at: 'reactive') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueReadOnly: anObject [
	^ (self vue at: 'readonly') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueRef: anObject [
	^ (self vue at: 'ref') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueShallowReactive: anObject [
	^ (self vue at: 'shallowReactive') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueShallowReadonly: anObject [
	^ (self vue at: 'shallowReadonly') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueShallowRef: anObject [
	^ (self vue at: 'shallowRef') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueToRaw: anObject [
"Returns the raw, original object of a reactive or readonly proxy. This is an escape hatch that can be used to temporarily read without incurring proxy access/tracking overhead or write without triggering changes. It is not recommended to hold a persistent reference to the original object. Use with caution."
	^ (self vue at: 'toRaw') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueTriggerRef: anObject [
	^ (self vue at: 'triggerRef') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueUnref: anObject [
"Returns the inner value if the argument is a ref, otherwise return the argument itself. This is a sugar function for val = isRef(val) ? val.value : val."
	^ (self vue at: 'unref') value: anObject
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueWatch: stuffToWatch do: aBlock withOptions: options [
	^ (self vue at: 'watch')
		value: stuffToWatch
		value: aBlock
		value: options
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueWatchEffect: aBlock [
	^ self vueWatchEffect: aBlock withOptions: #()
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueWatchEffect: aBlock onInvalidate: invalidateBlock withOptions: options [
	^ self
		vueWatchEffect: [ :onInvalidate | 
			aBlock value.
			onInvalidate value: invalidateBlock ]
		withOptions: options
]

{ #category : #'vue traits' }
PhxVueComponentAbstract >> vueWatchEffect: aBlock withOptions: options [
"Runs a function (evaluates the block) immediately while reactively tracking its dependencies and re-runs it whenever the dependencies are changed."
	^ (self vue at: 'watchEffect') value: aBlock value:  options
]
