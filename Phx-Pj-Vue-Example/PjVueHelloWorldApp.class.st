Class {
	#name : #PjVueHelloWorldApp,
	#superclass : #PjWebApplication,
	#traits : 'PhxPjPromiseTrait + PhxVue3Trait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxVue3Trait classTrait',
	#instVars : [
		'rectangle',
		'colour'
	],
	#category : #'Phx-Pj-Vue-Example'
}

{ #category : #'event handling' }
PjVueHelloWorldApp >> mountHelloWorldComp [

	| compDef app |
	compDef := PhxVueQuasarCounterComp componentDefinition.
	app := self vue createApp: compDef.
	app use: self quasar.
	app mount: '#app'
]

{ #category : #'event handling' }
PjVueHelloWorldApp >> onLoad [
]

{ #category : #'event handling' }
PjVueHelloWorldApp >> promiseAllLibrariesLoaded [

	^ (self promiseAll: {
			   (PhxSpaLoader promiseLoadLinkedCss:
				    'https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons').
			   (PhxSpaLoader promiseLoadLinkedCss:
				    'https://cdn.jsdelivr.net/npm/quasar@2.13.0/dist/quasar.css') })
		  then: [
			  self promiseAll: { ((PhxSpaLoader promiseLoadScript:
					    'https://cdn.jsdelivr.net/npm/vue@3/dist/vue.global.js')
					   then: [
						   self promiseAll: { (PhxSpaLoader promiseLoadScript:
								    'https://cdn.jsdelivr.net/npm/quasar@2.13.0/dist/quasar.umd.min.js') } ]) } ]
]

{ #category : #vue }
PjVueHelloWorldApp >> quasar [

	^ globalThis at: 'Quasar'
]

{ #category : #'event handling' }
PjVueHelloWorldApp >> start [

	super start.
	self body innerHTML: ''.  "Silly way to get rid of the message -> PharoJS: Develop in Pharo, run in JavaScript  "
	self promiseAllLibrariesLoaded then: [
		| x |
		x := PjDomBuilder newOnElement: self body.
		x div: [ x _id: 'app' ]. 
		self mountHelloWorldComp ]
]

{ #category : #vue }
PjVueHelloWorldApp >> vue [

	^ globalThis at: 'Vue'
]
