Trait {
	#name : #PhxVue3Trait,
	#category : #'Phx-Pj-Vue'
}

{ #category : #vue }
PhxVue3Trait >> console [
	^ self explicitRequirement
]

{ #category : #vue }
PhxVue3Trait >> h [
	^ (self vue at: 'h')
]

{ #category : #vue }
PhxVue3Trait >> vue [
	^ self explicitRequirement
]

{ #category : #vue }
PhxVue3Trait >> vueComputed: aBlock [
	^ (self vue at: 'computed') value: aBlock
]

{ #category : #utils }
PhxVue3Trait >> vueComputedGet: getBlock set: setBlock [

	^self vueComputed: { 
			('get' -> getBlock).
			('set' -> setBlock) } asJsObject
]

{ #category : #vue }
PhxVue3Trait >> vueGetCurrentScope [
	^ (self vue at: #vueGetCurrentScope) value
]

{ #category : #vue }
PhxVue3Trait >> vueIsProxy: anObject [
"Checks if an object is a proxy created by reactive or readonly"
	^ (self vue at: 'isProxy') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueIsReactive: anObject [
"Checks if an object is a reactive proxy created by reactive"
	^ (self vue at: 'isReactive') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueIsReadonly: anObject [
"Checks if an object is a readonly proxy created by readonly"
	^ (self vue at: 'isReadonly') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueIsRef: anObject [
"Checks if an object is a reactive proxy created by reactive"
	^ (self vue at: 'isRef') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueMarkRaw: anObject [
"Marks an object so that it will never be converted to a proxy. Returns the object itself.
See also: https://v3.vuejs.org/api/basic-reactivity.html#markraw"
	^ (self vue at: 'markRaw') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueNewEffectScopeDetached [
	^self vueNewEffectScopeDetached: true
]

{ #category : #vue }
PhxVue3Trait >> vueNewEffectScopeDetached: aBoolean [
	"self
		log:
			{'vueNewEffectScopeDetached:'.
			aBoolean}."
	^ (self vue at: 'effectScope') value: aBoolean
]

{ #category : #vue }
PhxVue3Trait >> vueNewEffectScopeNonDetached [
	^ self vueNewEffectScopeDetached: false
]

{ #category : #vue }
PhxVue3Trait >> vueReactive: anObject [
	^ (self vue at: 'reactive') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueReadOnly: anObject [
	^ (self vue at: 'readonly') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueRef: anObject [
	^ (self vue at: 'ref') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueShallowReactive: anObject [
	^ (self vue at: 'shallowReactive') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueShallowReadonly: anObject [
	^ (self vue at: 'shallowReadonly') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueShallowRef: anObject [
	^ (self vue at: 'shallowRef') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueToRaw: anObject [
"Returns the raw, original object of a reactive or readonly proxy. This is an escape hatch that can be used to temporarily read without incurring proxy access/tracking overhead or write without triggering changes. It is not recommended to hold a persistent reference to the original object. Use with caution."
	^ (self vue at: 'toRaw') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueTriggerRef: anObject [
	^ (self vue at: 'triggerRef') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueUnref: anObject [
"Returns the inner value if the argument is a ref, otherwise return the argument itself. This is a sugar function for val = isRef(val) ? val.value : val."
	^ (self vue at: 'unref') value: anObject
]

{ #category : #vue }
PhxVue3Trait >> vueWatch: stuffToWatch do: aBlock withOptions: options [
	^ (self vue at: 'watch')
		value: stuffToWatch
		value: aBlock
		value: options
]

{ #category : #vue }
PhxVue3Trait >> vueWatchEffect: aBlock [
	^ self vueWatchEffect: aBlock withOptions: #()
]

{ #category : #vue }
PhxVue3Trait >> vueWatchEffect: aBlock onInvalidate: invalidateBlock withOptions: options [
	^ self
		vueWatchEffect: [ :onInvalidate | 
			aBlock value.
			onInvalidate value: invalidateBlock ]
		withOptions: options
]

{ #category : #vue }
PhxVue3Trait >> vueWatchEffect: aBlock withOptions: options [
"Runs a function (evaluates the block) immediately while reactively tracking its dependencies and re-runs it whenever the dependencies are changed."
	^ (self vue at: 'watchEffect') value: aBlock value:  options
]
