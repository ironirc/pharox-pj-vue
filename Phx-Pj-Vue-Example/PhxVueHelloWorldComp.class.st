Class {
	#name : #PhxVueHelloWorldComp,
	#superclass : #PhxVueComponentAbstract,
	#category : #'Phx-Pj-Vue-Example'
}

{ #category : #rendering }
PhxVueHelloWorldComp >> renderVueWith: x [
	x div: 'Hello world'
]
