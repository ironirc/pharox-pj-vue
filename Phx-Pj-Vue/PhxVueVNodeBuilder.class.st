Class {
	#name : #PhxVueVNodeBuilder,
	#superclass : #PjDomController,
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
	self tag: ''{{tag}}'' with: aBlockOrString' asMustacheTemplate.
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
	self currentNode atSubDef: 'attrs' add: {(attrName -> aValue)}
]

{ #category : #'api-configuration' }
PhxVueVNodeBuilder >> _class: aStringOrArray [
	self currentNode atSubDef: 'class' add: aStringOrArray
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
 	self currentNode atSubDef: 'on' add: assocs
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
	self tag: 'qAjaxBar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qAvatar: aBlockOrString [
	self tag: 'qAvatar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBadge: aBlockOrString [
	self tag: 'qBadge' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBanner: aBlockOrString [
	self tag: 'qBanner' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBar: aBlockOrString [
	self tag: 'qBar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBreadcrumbs: aBlockOrString [
	self tag: 'qBreadcrumbs' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBreadcrumbsEl: aBlockOrString [
	self tag: 'qBreadcrumbsEl' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtn: aBlockOrString [
	self tag: 'qBtn' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnDropdown: aBlockOrString [
	self tag: 'qBtnDropdown' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnGroup: aBlockOrString [
	self tag: 'qBtnGroup' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qBtnToggle: aBlockOrString [
	self tag: 'qBtnToggle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCard: aBlockOrString [
	self tag: 'qCard' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCardActions: aBlockOrString [
	self tag: 'qCardActions' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCardSection: aBlockOrString [
	self tag: 'qCardSection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarousel: aBlockOrString [
	self tag: 'qCarousel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarouselControl: aBlockOrString [
	self tag: 'qCarouselControl' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCarouselSlide: aBlockOrString [
	self tag: 'qCarouselSlide' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qChatMessage: aBlockOrString [
	self tag: 'qChatMessage' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCheckbox: aBlockOrString [
	self tag: 'qCheckbox' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qChip: aBlockOrString [
	self tag: 'qChip' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qCircularProgress: aBlockOrString [
	self tag: 'qCircularProgress' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qColor: aBlockOrString [
	self tag: 'qColor' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDate: aBlockOrString [
	self tag: 'qDate' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDialog: aBlockOrString [
	self tag: 'qDialog' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qDrawer: aBlockOrString [
	self tag: 'qDrawer' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qEditor: aBlockOrString [
	self tag: 'qEditor' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qExpansionItem: aBlockOrString [
	self tag: 'qExpansionItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFab: aBlockOrString [
	self tag: 'qFab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFabAction: aBlockOrString [
	self tag: 'qFabAction' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qField: aBlockOrString [
	self tag: 'qField' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFile: aBlockOrString [
	self tag: 'qFile' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qFooter: aBlockOrString [
	self tag: 'qFooter' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qForm: aBlockOrString [
	self tag: 'qForm' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qHeader: aBlockOrString [
	self tag: 'qHeader' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qIcon: aBlockOrString [
	self tag: 'qIcon' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qImg: aBlockOrString [
	self tag: 'qImg' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInfiniteScroll: aBlockOrString [
	self tag: 'qInfiniteScroll' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInnerLoading: aBlockOrString [
	self tag: 'qInnerLoading' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qInput: aBlockOrString [
	self tag: 'qInput' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qIntersection: aBlockOrString [
	self tag: 'qIntersection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItem: aBlockOrString [
	self tag: 'qItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItemLabel: aBlockOrString [
	self tag: 'qItemLabel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qItemSection: aBlockOrString [
	self tag: 'qItemSection' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qKnob: aBlockOrString [
	self tag: 'qKnob' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qLayout: aBlockOrString [
	self tag: 'qLayout' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qLinearProgress: aBlockOrString [
	self tag: 'qLinearProgress' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qList: aBlockOrString [
	self tag: 'qList' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qMarkupTable: aBlockOrString [
	self tag: 'qMarkupTable' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qMenu: aBlockOrString [
	self tag: 'qMenu' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qNoSsr: aBlockOrString [
	self tag: 'qNoSsr' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qOptionGroup: aBlockOrString [
	self tag: 'qOptionGroup' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPage: aBlockOrString [
	self tag: 'qPage' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageContainer: aBlockOrString [
	self tag: 'qPageContainer' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageScroller: aBlockOrString [
	self tag: 'qPageScroller' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPageSticky: aBlockOrString [
	self tag: 'qPageSticky' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPagination: aBlockOrString [
	self tag: 'qPagination' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qParallax: aBlockOrString [
	self tag: 'qParallax' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPopupEdit: aBlockOrString [
	self tag: 'qPopupEdit' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPopupProxy: aBlockOrString [
	self tag: 'qPopupProxy' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qPullToRefresh: aBlockOrString [
	self tag: 'qPullToRefresh' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRadio: aBlockOrString [
	self tag: 'qRadio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRange: aBlockOrString [
	self tag: 'qRange' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRating: aBlockOrString [
	self tag: 'qRating' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qResizeObserver: aBlockOrString [
	self tag: 'qResizeObserver' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qResponsive: aBlockOrString [
	self tag: 'qResponsive' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qRouteTab: aBlockOrString [
	self tag: 'qRouteTab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qScrollArea: aBlockOrString [
	self tag: 'qScrollArea' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qScrollObserver: aBlockOrString [
	self tag: 'qScrollObserver' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSelect: aBlockOrString [
	self tag: 'qSelect' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSeparator: aBlockOrString [
	self tag: 'qSeparator' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSkeleton: aBlockOrString [
	self tag: 'qSkeleton' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlideItem: aBlockOrString [
	self tag: 'qSlideItem' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlideTransition: aBlockOrString [
	self tag: 'qSlideTransition' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSlider: aBlockOrString [
	self tag: 'qSlider' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpace: aBlockOrString [
	self tag: 'qSpace' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinner: aBlockOrString [
	self tag: 'qSpinner' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerAudio: aBlockOrString [
	self tag: 'qSpinnerAudio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerBall: aBlockOrString [
	self tag: 'qSpinnerBall' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerBars: aBlockOrString [
	self tag: 'qSpinnerBars' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerComment: aBlockOrString [
	self tag: 'qSpinnerComment' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerCube: aBlockOrString [
	self tag: 'qSpinnerCube' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerDots: aBlockOrString [
	self tag: 'qSpinnerDots' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerFacebook: aBlockOrString [
	self tag: 'qSpinnerFacebook' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerGears: aBlockOrString [
	self tag: 'qSpinnerGears' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerGrid: aBlockOrString [
	self tag: 'qSpinnerGrid' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerHearts: aBlockOrString [
	self tag: 'qSpinnerHearts' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerHourglass: aBlockOrString [
	self tag: 'qSpinnerHourglass' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerInfinity: aBlockOrString [
	self tag: 'qSpinnerInfinity' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerIos: aBlockOrString [
	self tag: 'qSpinnerIos' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerOval: aBlockOrString [
	self tag: 'qSpinnerOval' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerPie: aBlockOrString [
	self tag: 'qSpinnerPie' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerPuff: aBlockOrString [
	self tag: 'qSpinnerPuff' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerRadio: aBlockOrString [
	self tag: 'qSpinnerRadio' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerRings: aBlockOrString [
	self tag: 'qSpinnerRings' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSpinnerTail: aBlockOrString [
	self tag: 'qSpinnerTail' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qSplitter: aBlockOrString [
	self tag: 'qSplitter' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStep: aBlockOrString [
	self tag: 'qStep' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStepper: aBlockOrString [
	self tag: 'qStepper' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qStepperNavigation: aBlockOrString [
	self tag: 'qStepperNavigation' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTab: aBlockOrString [
	self tag: 'qTab' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabPanel: aBlockOrString [
	self tag: 'qTabPanel' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabPanels: aBlockOrString [
	self tag: 'qTabPanels' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTable: aBlockOrString [
	self tag: 'qTable' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTabs: aBlockOrString [
	self tag: 'qTabs' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTd: aBlockOrString [
	self tag: 'qTd' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTh: aBlockOrString [
	self tag: 'qTh' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTime: aBlockOrString [
	self tag: 'qTime' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTimeline: aBlockOrString [
	self tag: 'qTimeline' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTimelineEntry: aBlockOrString [
	self tag: 'qTimelineEntry' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToggle: aBlockOrString [
	self tag: 'qToggle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToolbar: aBlockOrString [
	self tag: 'qToolbar' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qToolbarTitle: aBlockOrString [
	self tag: 'qToolbarTitle' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTooltip: aBlockOrString [
	self tag: 'qTooltip' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTr: aBlockOrString [
	self tag: 'qTr' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qTree: aBlockOrString [
	self tag: 'qTree' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploader: aBlockOrString [
	self tag: 'qUploader' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploaderAddTrigger: aBlockOrString [
	self tag: 'qUploaderAddTrigger' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qUploaderBase: aBlockOrString [
	self tag: 'qUploaderBase' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qVideo: aBlockOrString [
	self tag: 'qVideo' with: aBlockOrString
]

{ #category : #'api-tags-quasar' }
PhxVueVNodeBuilder >> qVirtualScroll: aBlockOrString [
	self tag: 'qVirtualScroll' with: aBlockOrString
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
	(stuff isKindOf: Association)
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
	self _prop: 'value' set: (self currentComponent perform: aSymbol).
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

{ #category : #accessing }
PhxVueVNodeBuilder >> vNode [
	^ vNode
]
