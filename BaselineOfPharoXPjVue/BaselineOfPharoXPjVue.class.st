Class {
	#name : #BaselineOfPharoXPjVue,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoXPjVue
}

{ #category : #baselines }
BaselineOfPharoXPjVue >> baseline: spec [
	<baseline>

	self compatibility: spec.
		
	spec for: #'common' do: [
		spec postLoadDoIt: #'postload:package:'.
		self 
			prerequisites: spec;		
			packages: spec;
			groups: spec	
	]
]

{ #category : #'private - accessing' }
BaselineOfPharoXPjVue >> compatibility: spec [

	"Define a 'Compatibility' group that can be used as a dependency later to overcome differences in Pharo releases"

	
]

{ #category : #'private - accessing' }
BaselineOfPharoXPjVue >> groups: spec [

]

{ #category : #'private - accessing' }
BaselineOfPharoXPjVue >> packages: spec [

	spec package: 'Phx-Pj-Vue' with: [  ]
]

{ #category : #baselines }
BaselineOfPharoXPjVue >> postload: aLoader package: aPackageSpec [
	
]

{ #category : #'private - accessing' }
BaselineOfPharoXPjVue >> prerequisites: spec [
	spec baseline: 'PharoXBasics' with: [ spec repository: 'github://ironirc/pharox-pj-basics' ].

]
