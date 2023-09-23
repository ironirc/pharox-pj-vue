Class {
	#name : #'PhxVueBridgeTestCase_Basic',
	#superclass : #PjBridgeTestCase,
	#instVars : [
		'testClass'
	],
	#category : #'Phx-Pj-Vue-tests'
}

{ #category : #tests }
PhxVueBridgeTestCase_Basic >> testVueReactivityOutsideComponent [

	(self evalBlock: [ PhxVueBridgeTestCase_Loader promiseLoaded_Vue3 ])
		then: [
			| vue rCollection idx interval |
			document body innerHTML: ''.
			vue := globalThis at: 'Vue'.
			rCollection := (vue at: 'reactive') value: OrderedCollection new.
			(vue at: 'watchEffect') value: [
				| msg div |
				msg := String streamContents: [ :ws |
					       rCollection
						       do: [ :each | ws << each ]
						       separatedBy: [ ws << ', ' ] ].
				div := document createElement: 'DIV'.
				div innerHTML: msg.
				document body appendChild: div ].
			rCollection add: 'Apple'.
			idx := 0.
			interval := globalThis
				            setInterval: [
					            idx := idx + 1.
					            rCollection add: idx asString
					            "	idx = 3
						ifTrue: [ global clearInterval: interval ]" ]
				            with: 10 ].
	self halt
]
