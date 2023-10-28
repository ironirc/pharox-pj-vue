Class {
	#name : #PhxVueQuasarCounterComp,
	#superclass : #PhxVueComponentAbstract,
	#instVars : [
		'counter'
	],
	#category : #'Phx-Pj-Vue-Example'
}

{ #category : #'initialize-release' }
PhxVueQuasarCounterComp >> initialize [

	super initialize.
	counter := self vueRef: 0
]

{ #category : #rendering }
PhxVueQuasarCounterComp >> renderVueWith: x [

	x div: [ x _class: 'column justify-center items-center q-ma-lg'.
    x qCard: [ x _class: 'q-pa-md'.
        x div: [ x _class: 'text-h6 q-my-md'.
            x << 'This is a counter using vue3/quasar2 and PharoJS' ].
        x div: [ x _class: 'row items-center'.
            x qBtn: [
                x _onClick: [ counter value: counter value - 1 ].
                x _attr: 'label' set: '-'.
                x _attr: 'color' set: 'primary' ].
            x qItemLabel: [
                x _class: 'q-mx-md'.
                x << counter value ].
            x qBtn: [
                x _onClick: [ counter value: counter value + 1 ].
                x _attr: 'label' set: '+'.
                x _attr: 'color' set: 'secondary' ] ] ] ]

]
