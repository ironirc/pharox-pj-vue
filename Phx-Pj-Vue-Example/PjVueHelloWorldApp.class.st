Class {
	#name : #PjVueHelloWorldApp,
	#superclass : #PjWebApplication,
	#instVars : [
		'rectangle',
		'colour'
	],
	#category : #'Phx-Pj-Vue-Example'
}

{ #category : #'event handling' }
PjVueHelloWorldApp >> onLoad [
]

{ #category : #'event handling' }
PjVueHelloWorldApp >> promiseAllLibrariesLoaded [

	^ (self promiseAll: {
			   (PhxSpaLoader promiseLoadLinkedCss:
				    'https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons').
			   (PhxSpaLoader promiseLoadLinkedCss:
				    'https://cdn.jsdelivr.net/npm/quasar@1.13.1/dist/quasar.min.css') })
		  then: [
			  self promiseAll: {
					  (PhxSpaLoader promiseLoadScript:
						   'https://code.jquery.com/jquery-3.3.1.slim.min.js').
					  (PhxSpaLoader promiseLoadScript:
						   'https://cdnjs.cloudflare.com/ajax/libs/axios/0.19.2/axios.min.js').
					  ((PhxSpaLoader promiseLoadScript:
						    'https://cdn.jsdelivr.net/npm/vue@2.6.12/dist/vue.js')
						   then: [
							   | vueClass |
							   vueClass := globalThis instVarNamed: 'Vue'.
							   vueClass config instVarNamed: 'devtools' put: true.
							   self promiseAll: {
									   (PhxSpaLoader promiseLoadScript:
										    'https://cdn.jsdelivr.net/npm/@vue/composition-api@1.0.0-beta.20/dist/vue-composition-api.js').
									   "https://cdn.jsdelivr.net/npm/@vue/composition-api@1.0.0-beta.11"

									   (PhxSpaLoader promiseLoadScript:
										    'https://unpkg.com/vue-router@3/dist/vue-router.js').
									   (PhxSpaLoader promiseLoadScript:
										    'https://cdn.jsdelivr.net/npm/quasar@1.13.1/dist/quasar.umd.js') } ]) } ]
]

{ #category : #'event handling' }
PjVueHelloWorldApp >> start [
	super start.
	self setupDOM
]
