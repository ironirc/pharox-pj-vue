Class {
	#name : #PhxVueVNodeBuilder,
	#superclass : #PjDomController,
	#traits : 'PhxVue3Trait',
	#classTraits : 'PhxVue3Trait classTrait',
	#instVars : [
		'stack',
		'createElementFn',
		'vNode',
		'currentComponent'
	],
	#category : #'Phx-Pj-Vue-Core'
}

{ #category : #dev }
PhxVueVNodeBuilder class >> compileAll [
	self quasarTags do: [ :each | self compileTagFor: each ]
]

{ #category : #dev }
PhxVueVNodeBuilder class >> compileTagFor: qClassName [
	| sourceCodeMt tag mtVars sourceCode |
	sourceCodeMt := '{{tag}}: aBlockOrString
	self resolvedTag: ''{{tag}}'' with: aBlockOrString' asMustacheTemplate.
	tag := String
		streamContents: [ :ws | ws << $q << (qClassName readStream next;  upToEnd) ].
	mtVars := Dictionary new.
	mtVars at: 'tag' put: tag.
	sourceCode := sourceCodeMt value: mtVars.
	self compile: sourceCode classified: 'generated'
]

{ #category : #'instance creation' }
PhxVueVNodeBuilder class >> newOnH: cef [
	^self new
		createElementFn: cef;
		yourself
]

{ #category : #dev }
PhxVueVNodeBuilder class >> quasarTags [
	^ #('QAjaxBar' 'QAvatar' 'QBadge' 'QBanner' 'QBar' 'QBreadcrumbs' 'QBreadcrumbsEl' 'QBtn' 'QBtnDropdown' 'QBtnGroup' 'QBtnToggle' 'QCard' 'QCardActions' 'QCardSection' 'QCarousel' 'QCarouselControl' 'QCarouselSlide' 'QChatMessage' 'QCheckbox' 'QChip' 'QCircularProgress' 'QColor' 'QDate' 'QDialog' 'QDrawer' 'QEditor' 'QExpansionItem' 'QFab' 'QFabAction' 'QField' 'QFile' 'QFooter' 'QForm' 'QHeader' 'QIcon' 'QImg' 'QInfiniteScroll' 'QInnerLoading' 'QInput' 'QIntersection' 'QItem' 'QItemLabel' 'QItemSection' 'QKnob' 'QLayout' 'QLinearProgress' 'QList' 'QMarkupTable' 'QMenu' 'QNoSsr' 'QOptionGroup' 'QPage' 'QPageContainer' 'QPageScroller' 'QPageSticky' 'QPagination' 'QParallax' 'QPopupEdit' 'QPopupProxy' 'QPullToRefresh' 'QRadio' 'QRange' 'QRating' 'QResizeObserver' 'QResponsive' 'QRouteTab' 'QScrollArea' 'QScrollObserver' 'QSelect' 'QSeparator' 'QSkeleton' 'QSlideItem' 'QSlideTransition' 'QSlider' 'QSpace' 'QSpinner' 'QSpinnerAudio' 'QSpinnerBall' 'QSpinnerBars' 'QSpinnerComment' 'QSpinnerCube' 'QSpinnerDots' 'QSpinnerFacebook' 'QSpinnerGears' 'QSpinnerGrid' 'QSpinnerHearts' 'QSpinnerHourglass' 'QSpinnerInfinity' 'QSpinnerIos' 'QSpinnerOval' 'QSpinnerPie' 'QSpinnerPuff' 'QSpinnerRadio' 'QSpinnerRings' 'QSpinnerTail' 'QSplitter' 'QStep' 'QStepper' 'QStepperNavigation' 'QTab' 'QTabPanel' 'QTabPanels' 'QTable' 'QTabs' 'QTd' 'QTh' 'QTime' 'QTimeline' 'QTimelineEntry' 'QToggle' 'QToolbar' 'QToolbarTitle' 'QTooltip' 'QTr' 'QTree' 'QUploader' 'QUploaderAddTrigger' 'QUploaderBase' 'QVideo' 'QVirtualScroll')
]

{ #category : #api }
PhxVueVNodeBuilder >> << aString [
 	stack last children: aString
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _attr: anArray [
	self currentNode atSubDef: 'attrs' add: anArray
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _attr: attrName set: aValue [
"	self currentNode atSubDef: 'attrs' add: {(attrName -> aValue)}"
	self currentNode defAt: attrName put: aValue.
	console log: 'set attr' with: attrName with: aValue with: self currentNode
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _attrs: aStringOrArray [
	aStringOrArray isString
		ifTrue: [ (' ' split: aStringOrArray)
				do: [ :each | self currentNode defAt: each put: true ] ]
		ifFalse: [ aStringOrArray
				do: [ :def | 
					def isString
						ifTrue: [ self currentNode defAt: def put: '' ]
						ifFalse: [ self currentNode defAt: def key put: def value ] ] ]
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _class: aStringOrArray [
	self currentNode defAt: 'class' put: aStringOrArray
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _domProps: assocs [
	self currentNode atSubDef: 'domProps' add: assocs
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _nativeOn: assocs [
	"console
		log: 'adding nativeOn assocs to: '
		with: stack last
		with: assocs.
	stack last tag = 'div'
		ifTrue: [ self halt ]."
	self currentNode atSubDef: 'nativeOn' add: assocs
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _nativeOn: event do: aBlock [
	self _nativeOn: {(event -> aBlock)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _on: assocs [

	assocs do: [ :assoc |
		self _attr: 'on' , assoc key capitalized set: assoc value ]
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _on: event do: aBlock [
	self _on: {(event -> aBlock)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _onChange: aBlock [
	self _on: {('change' -> aBlock)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _onClick: aBlock [
	self _on: {('click' -> aBlock)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _onInput: aBlock [
	self _on: {('input' -> aBlock)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _prop: propName set: aValue [
	self currentNode atSubDef: 'props' add: {(propName -> aValue)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _props: anArray [
	self currentNode atSubDef: 'props' add: anArray
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _scopedSlot: slotName with: aBlock [
	| x |
	x := PhxVueVNodeBuilder
		newOnH: self createElementFn.
	self currentNode
		atSubDef: 'scopedSlots'
		add:
			{(slotName
				-> [ aBlock value: x.
					x vNode ])}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _slot: slotName with: aBlock [
	| x |
	x := PhxVueVNodeBuilder
		newOnH: self createElementFn.
	self currentNode
		atSubDef: 'slots'
		add:
			{(slotName
				-> [ aBlock value: x.
					x vNode ])}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _style: anArray [
	self currentNode atSubDef: 'style' add: anArray
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _style: styleName set: aValue [
	self currentNode atSubDef: 'style' add: {(styleName -> aValue)}
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> a: aBlockOrString [
	^self tag: 'a' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> button: aBlockOrString [
	^self tag: 'button' with: aBlockOrString
]

{ #category : #api }
PhxVueVNodeBuilder >> comp: aComponent config: aBlockOrString [
	console log: 'builder adding comp: ' with: aComponent "with: aBlockOrString value".
	self tag: aComponent componentDefinition with: aBlockOrString
]

{ #category : #accessing }
PhxVueVNodeBuilder >> createElementFn [
	"alias h"
	^ createElementFn
]

{ #category : #accessing }
PhxVueVNodeBuilder >> createElementFn: anObject [
	createElementFn := anObject
]

{ #category : #accessing }
PhxVueVNodeBuilder >> currentComponent [
	^ currentComponent
]

{ #category : #accessing }
PhxVueVNodeBuilder >> currentComponent: anObject [
	currentComponent := anObject
]

{ #category : #private }
PhxVueVNodeBuilder >> currentNode [
	^ stack last
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> div: aBlockOrString [
	^self tag: 'div' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h1: aBlockOrString [
	^self tag: 'h1' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h2: aBlockOrString [
	^self tag: 'h2' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h3: aBlockOrString [
	^self tag: 'h3' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h4: aBlockOrString [
	^self tag: 'h4' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h5: aBlockOrString [
	^self tag: 'h5' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> h6: aBlockOrString [
	^self tag: 'h6' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> iframe: aBlockOrString [
	^self tag: 'iframe' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> img: aBlockOrString [
	^self tag: 'img' with: aBlockOrString 
]

{ #category : #'initialize-release' }
PhxVueVNodeBuilder >> initialize [
	super initialize.
	stack := OrderedCollection new
]

{ #category : #'api-tags-vue' }
PhxVueVNodeBuilder >> keepAlive: aBlockOrString [
	self tag: 'keepAlive' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> p: aBlockOrString [ 
	^self tag: 'p' with: aBlockOrString
]

{ #category : #private }
PhxVueVNodeBuilder >> privateBuildTagWithBlockOrString: aBlockOrString [
	aBlockOrString isBlock
		ifTrue: [ | blockResult |
			blockResult := aBlockOrString cull: self.
			blockResult
				ifNotNil: [
					blockResult isString
						ifTrue: [ "self << blockResult" ] ].
			blockResult ]
		ifFalse: [ self << aBlockOrString ]
]

{ #category : #private }
PhxVueVNodeBuilder >> privateBuildTagWithConfigBlock: aBlock [
	self configBuilder privateBuildTagWithConfigBlock: aBlock
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qAjaxBar: aBlockOrString [
	self resolvedTag: 'qAjaxBar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qAvatar: aBlockOrString [
	self resolvedTag: 'qAvatar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBadge: aBlockOrString [
	self resolvedTag: 'qBadge' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBanner: aBlockOrString [
	self resolvedTag: 'qBanner' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBar: aBlockOrString [
	self resolvedTag: 'qBar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBreadcrumbs: aBlockOrString [
	self resolvedTag: 'qBreadcrumbs' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBreadcrumbsEl: aBlockOrString [
	self resolvedTag: 'qBreadcrumbsEl' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtn: aBlockOrString [
	self resolvedTag: 'qBtn' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnDropdown: aBlockOrString [
	self resolvedTag: 'qBtnDropdown' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnGroup: aBlockOrString [
	self resolvedTag: 'qBtnGroup' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnToggle: aBlockOrString [
	self resolvedTag: 'qBtnToggle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCard: aBlockOrString [
	self resolvedTag: 'qCard' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCardActions: aBlockOrString [
	self resolvedTag: 'qCardActions' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCardSection: aBlockOrString [
	self resolvedTag: 'qCardSection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarousel: aBlockOrString [
	self resolvedTag: 'qCarousel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarouselControl: aBlockOrString [
	self resolvedTag: 'qCarouselControl' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarouselSlide: aBlockOrString [
	self resolvedTag: 'qCarouselSlide' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qChatMessage: aBlockOrString [
	self resolvedTag: 'qChatMessage' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCheckbox: aBlockOrString [
	self resolvedTag: 'qCheckbox' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qChip: aBlockOrString [
	self resolvedTag: 'qChip' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCircularProgress: aBlockOrString [
	self resolvedTag: 'qCircularProgress' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qColor: aBlockOrString [
	self resolvedTag: 'qColor' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDate: aBlockOrString [
	self resolvedTag: 'qDate' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDialog: aBlockOrString [
	self resolvedTag: 'qDialog' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDrawer: aBlockOrString [
	self resolvedTag: 'qDrawer' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qEditor: aBlockOrString [
	self resolvedTag: 'qEditor' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qExpansionItem: aBlockOrString [
	self resolvedTag: 'qExpansionItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFab: aBlockOrString [
	self resolvedTag: 'qFab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFabAction: aBlockOrString [
	self resolvedTag: 'qFabAction' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qField: aBlockOrString [
	self resolvedTag: 'qField' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFile: aBlockOrString [
	self resolvedTag: 'qFile' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFooter: aBlockOrString [
	self resolvedTag: 'qFooter' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qForm: aBlockOrString [
	self resolvedTag: 'qForm' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qHeader: aBlockOrString [
	self resolvedTag: 'qHeader' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qIcon: aBlockOrString [
	self resolvedTag: 'qIcon' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qImg: aBlockOrString [
	self resolvedTag: 'qImg' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInfiniteScroll: aBlockOrString [
	self resolvedTag: 'qInfiniteScroll' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInnerLoading: aBlockOrString [
	self resolvedTag: 'qInnerLoading' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInput: aBlockOrString [
	self resolvedTag: 'qInput' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qIntersection: aBlockOrString [
	self resolvedTag: 'qIntersection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItem: aBlockOrString [
	self resolvedTag: 'qItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItemLabel: aBlockOrString [
	self resolvedTag: 'qItemLabel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItemSection: aBlockOrString [
	self resolvedTag: 'qItemSection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qKnob: aBlockOrString [
	self resolvedTag: 'qKnob' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qLayout: aBlockOrString [
	self resolvedTag: 'qLayout' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qLinearProgress: aBlockOrString [
	self resolvedTag: 'qLinearProgress' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qList: aBlockOrString [
	self resolvedTag: 'qList' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qMarkupTable: aBlockOrString [
	self resolvedTag: 'qMarkupTable' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qMenu: aBlockOrString [
	self resolvedTag: 'qMenu' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qNoSsr: aBlockOrString [
	self resolvedTag: 'qNoSsr' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qOptionGroup: aBlockOrString [
	self resolvedTag: 'qOptionGroup' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPage: aBlockOrString [
	self resolvedTag: 'qPage' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageContainer: aBlockOrString [
	self resolvedTag: 'qPageContainer' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageScroller: aBlockOrString [
	self resolvedTag: 'qPageScroller' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageSticky: aBlockOrString [
	self resolvedTag: 'qPageSticky' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPagination: aBlockOrString [
	self resolvedTag: 'qPagination' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qParallax: aBlockOrString [
	self resolvedTag: 'qParallax' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPopupEdit: aBlockOrString [
	self resolvedTag: 'qPopupEdit' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPopupProxy: aBlockOrString [
	self resolvedTag: 'qPopupProxy' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPullToRefresh: aBlockOrString [
	self resolvedTag: 'qPullToRefresh' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRadio: aBlockOrString [
	self resolvedTag: 'qRadio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRange: aBlockOrString [
	self resolvedTag: 'qRange' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRating: aBlockOrString [
	self resolvedTag: 'qRating' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qResizeObserver: aBlockOrString [
	self resolvedTag: 'qResizeObserver' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qResponsive: aBlockOrString [
	self resolvedTag: 'qResponsive' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRouteTab: aBlockOrString [
	self resolvedTag: 'qRouteTab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qScrollArea: aBlockOrString [
	self resolvedTag: 'qScrollArea' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qScrollObserver: aBlockOrString [
	self resolvedTag: 'qScrollObserver' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSelect: aBlockOrString [
	self resolvedTag: 'qSelect' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSeparator: aBlockOrString [
	self resolvedTag: 'qSeparator' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSkeleton: aBlockOrString [
	self resolvedTag: 'qSkeleton' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlideItem: aBlockOrString [
	self resolvedTag: 'qSlideItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlideTransition: aBlockOrString [
	self resolvedTag: 'qSlideTransition' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlider: aBlockOrString [
	self resolvedTag: 'qSlider' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpace: aBlockOrString [
	self resolvedTag: 'qSpace' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinner: aBlockOrString [
	self resolvedTag: 'qSpinner' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerAudio: aBlockOrString [
	self resolvedTag: 'qSpinnerAudio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerBall: aBlockOrString [
	self resolvedTag: 'qSpinnerBall' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerBars: aBlockOrString [
	self resolvedTag: 'qSpinnerBars' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerComment: aBlockOrString [
	self resolvedTag: 'qSpinnerComment' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerCube: aBlockOrString [
	self resolvedTag: 'qSpinnerCube' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerDots: aBlockOrString [
	self resolvedTag: 'qSpinnerDots' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerFacebook: aBlockOrString [
	self resolvedTag: 'qSpinnerFacebook' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerGears: aBlockOrString [
	self resolvedTag: 'qSpinnerGears' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerGrid: aBlockOrString [
	self resolvedTag: 'qSpinnerGrid' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerHearts: aBlockOrString [
	self resolvedTag: 'qSpinnerHearts' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerHourglass: aBlockOrString [
	self resolvedTag: 'qSpinnerHourglass' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerInfinity: aBlockOrString [
	self resolvedTag: 'qSpinnerInfinity' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerIos: aBlockOrString [
	self resolvedTag: 'qSpinnerIos' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerOval: aBlockOrString [
	self resolvedTag: 'qSpinnerOval' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerPie: aBlockOrString [
	self resolvedTag: 'qSpinnerPie' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerPuff: aBlockOrString [
	self resolvedTag: 'qSpinnerPuff' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerRadio: aBlockOrString [
	self resolvedTag: 'qSpinnerRadio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerRings: aBlockOrString [
	self resolvedTag: 'qSpinnerRings' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerTail: aBlockOrString [
	self resolvedTag: 'qSpinnerTail' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSplitter: aBlockOrString [
	self resolvedTag: 'qSplitter' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStep: aBlockOrString [
	self resolvedTag: 'qStep' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStepper: aBlockOrString [
	self resolvedTag: 'qStepper' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStepperNavigation: aBlockOrString [
	self resolvedTag: 'qStepperNavigation' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTab: aBlockOrString [
	self resolvedTag: 'qTab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabPanel: aBlockOrString [
	self resolvedTag: 'qTabPanel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabPanels: aBlockOrString [
	self resolvedTag: 'qTabPanels' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTable: aBlockOrString [
	self resolvedTag: 'qTable' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabs: aBlockOrString [
	self resolvedTag: 'qTabs' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTd: aBlockOrString [
	self resolvedTag: 'qTd' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTh: aBlockOrString [
	self resolvedTag: 'qTh' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTime: aBlockOrString [
	self resolvedTag: 'qTime' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTimeline: aBlockOrString [
	self resolvedTag: 'qTimeline' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTimelineEntry: aBlockOrString [
	self resolvedTag: 'qTimelineEntry' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToggle: aBlockOrString [
	self resolvedTag: 'qToggle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToolbar: aBlockOrString [
	self resolvedTag: 'qToolbar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToolbarTitle: aBlockOrString [
	self resolvedTag: 'qToolbarTitle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTooltip: aBlockOrString [
	self resolvedTag: 'qTooltip' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTr: aBlockOrString [
	self resolvedTag: 'qTr' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTree: aBlockOrString [
	self resolvedTag: 'qTree' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploader: aBlockOrString [
	self resolvedTag: 'qUploader' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploaderAddTrigger: aBlockOrString [
	self resolvedTag: 'qUploaderAddTrigger' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploaderBase: aBlockOrString [
	self resolvedTag: 'qUploaderBase' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qVideo: aBlockOrString [
	self resolvedTag: 'qVideo' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qVirtualScroll: aBlockOrString [
	self resolvedTag: 'qVirtualScroll' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> resolvedTag: tag with: aBlockOrString [

	self tag: (self vue resolveComponent: tag ) with: aBlockOrString
]

{ #category : #'api-tags-vue' }
PhxVueVNodeBuilder >> routerView: aBlockOrString [
	self tag: 'routerView' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> span: aBlockOrString [ 
	^self tag: 'span' with: aBlockOrString
]

{ #category : #private }
PhxVueVNodeBuilder >> tag: tag with: stuff [
	| vn |
	stack add: (PhxVueVNodeDefinition newWithTag: tag).
	(stuff isKindOf: Association "not ok => ConfigBlock not implemented")
		ifTrue: [
			self privateBuildTagWithConfigBlock: stuff key.
			self privateBuildTagWithBlockOrString: stuff value ]
		ifFalse: [ self privateBuildTagWithBlockOrString: stuff ].
	vn := stack removeLast
		evaluateWithCreateElementFunction: createElementFn.
	stack isEmpty
		ifFalse: [ stack last addChild: vn ].
	vNode := vn
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> tbody: aBlockOrString [
	^self tag: 'tbody' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> td: aBlockOrString [
	^self tag: 'td' with: aBlockOrString
]

{ #category : #'api-tags-html' }
PhxVueVNodeBuilder >> tr: aBlockOrString [
	^self tag: 'tr' with: aBlockOrString
]

{ #category : #'api-tags-vue' }
PhxVueVNodeBuilder >> transition: aBlockOrString [
	self tag: 'transition' with: aBlockOrString
]

{ #category : #api }
PhxVueVNodeBuilder >> vModel: aSymbol [

	self currentNode
		defAt: 'modelValue'
		put: (self currentComponent perform: aSymbol).
	self currentNode defAt: 'onUpdate:model-value' put: [ :anObject |
		self currentComponent perform: aSymbol asMutator with: anObject ]
]

{ #category : #api }
PhxVueVNodeBuilder >> vModel: aSymbol bindObject: anObject [
	self _prop: 'value' set: (anObject perform: aSymbol).
	"console
		log: 'vModelOnInput:'
		with: aSymbol
		with: stack last
		with: stack last needsInputBinding."
	self
		_on:
			{('input'
				->
					[ :aValue | anObject perform: aSymbol , ':' with: aValue ])}.
	self
		_nativeOn:
			{('input'
				-> [ :ev | 
					ev stopImmediatePropagation
					"console log: 'native input: ' with: ev" ]).
			('change'
				-> [ :ev | 
					ev stopImmediatePropagation
					"console log: 'native change: ' with: ev" ])}
]

{ #category : #api }
PhxVueVNodeBuilder >> vModelOld: aSymbol [
self currentNode defAt: 'modelValue' put: (self currentComponent at: aSymbol).
"	self _prop: 'v-model' set: (self currentComponent perform: aSymbol)."
	"console
		log: 'vModelOnInput:'
		with: aSymbol
		with: stack last
		with: (self currentComponent perform: aSymbol)."
	self
		_on:
			{('input'
				->
					[ :anObject | self currentComponent perform: aSymbol , ':' with: anObject ])}.
	self
		_nativeOn:
			{('input'
				-> [ :ev | 
					ev stopImmediatePropagation
					"console log: 'native input: ' with: ev" ]).
			('change'
				-> [ :ev | 
					ev stopImmediatePropagation
					"console log: 'native change: ' with: ev" ])}
]

{ #category : #accessing }
PhxVueVNodeBuilder >> vNode [
	^ vNode
]

{ #category : #vue }
PhxVueVNodeBuilder >> vue [

	^ globalThis at: 'Vue'
]
