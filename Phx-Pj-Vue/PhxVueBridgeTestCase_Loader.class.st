Class {
	#name : #'PhxVueBridgeTestCase_Loader',
	#superclass : #PhxSpaLoader,
	#category : #'Phx-Pj-Vue-tests'
}

{ #category : #promises }
PhxVueBridgeTestCase_Loader class >> promiseLoaded_Vue2_6_12_VueCompApi1_0_0 [
	^ self
		promiseAll:
			{(self
				promiseLoadScript: 'https://code.jquery.com/jquery-3.3.1.slim.min.js').
			((self
				promiseLoadScript: 'https://cdn.jsdelivr.net/npm/vue@2.6.12/dist/vue.js')
				then: [ | vueClass |
					vueClass := global instVarNamed: 'Vue'.
					vueClass config instVarNamed: 'devtools' put: true.
					self
						promiseAll:
							{(self
								promiseLoadScript:
									'https://cdn.jsdelivr.net/npm/@vue/composition-api@1.0.0-beta.20/dist/vue-composition-api.js')} ])}
]

{ #category : #promises }
PhxVueBridgeTestCase_Loader class >> promiseLoaded_Vue3 [
	^ self promiseLoadScript: 'https://unpkg.com/vue@next'
]
