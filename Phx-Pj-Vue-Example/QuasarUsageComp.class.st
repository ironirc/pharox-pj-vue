Class {
	#name : #QuasarUsageComp,
	#superclass : #PhxVueComponentAbstract,
	#instVars : [
		'drawerLeft',
		'drawerRight'
	],
	#category : #'Phx-Pj-Vue-Example'
}

{ #category : #'initialize-release' }
QuasarUsageComp >> initialize [

	super initialize.
	drawerLeft := self vueRef: true.
	drawerRight := self vueRef: false
]

{ #category : #rendering }
QuasarUsageComp >> renderBtn: x [

	x h4: 'Button Usage - Standard'.
	x div: [
		x _class: 'q-pa-md q-gutter-sm'.
		x qBtn: [ x _attr: 'color' set: 'white'; _attr: 'text-color' set: 'black'; _attr: 'label' set: 'Standard' ].
		x qBtn: [ x _attr: 'color' set: 'primary'; _attr: 'label' set: 'Primary' ].
		x qBtn: [ x _attr: 'color' set: 'secondary'; _attr: 'label' set: 'Secondary' ].
		x qBtn: [ x _attr: 'color' set: 'amber'; _attr: 'glossy' set: true; _attr: 'label' set: 'Amber' ].
		x qBtn: [ x _attr: 'color' set: 'brown-5'; _attr: 'label' set: 'Brown 5' ].
		x qBtn: [ x _attr: 'color' set: 'deep-orange'; _attr: 'glossy' set: true; _attr: 'label' set: 'Deep Orange' ].
		x qBtn: [ x _attr: 'color' set: 'purple'; _attr: 'label' set: 'Purple' ].
		x qBtn: [ x _attr: 'color' set: 'black'; _attr: 'label' set: 'Black' ] ]

]

{ #category : #rendering }
QuasarUsageComp >> renderBtnDropdown: x [

	x h4: 'Button Dropdown Usage'.
	x div: [
		x _class: 'q-pa-md'.
		x qBtnDropdown: [
			x _attrs: {'color' -> 'primary'. 'label' -> 'Dropdown Button'}.
			x qList: [
				x qItem: [
					x _attrs: {'clickable'. 'v-close-popup'}; _onClick: 'onItemClick'.
					x qItemSection: [ x qItemLabel: 'Photo' ] ].
				x qItem: [
					x _attrs: {'clickable'. 'v-close-popup'}; _onClick: 'onItemClick'.
					x qItemSection: [ x qItemLabel: 'Videos' ] ].
				x qItem: [
					x _attrs: {'clickable'. 'v-close-popup'}; _onClick: 'onItemClick'.
					x qItemSection: [ x qItemLabel: 'Articles' ] ] ] ] ]
]

{ #category : #rendering }
QuasarUsageComp >> renderBtnGroup: x [

	x h4: 'Button Group Usage'.
	x div: [
		x _class: 'q-pa-md q-gutter-y-md column items-start'.
		x qBtnGroup: [
			x _attr: 'push' set: true.
			x qBtn: [ x _attrs: {'label'->'First'. 'icon'->'timeline'} ].
			x qBtn: [ x _attrs: {'label'->'Second'. 'icon'->'visibility'} ].
			x qBtn: [ x _attrs: {'label'->'Third'. 'icon'->'update'} ] ].
		x qBtnGroup: [
			x _attr: 'push' set: true.
			x qBtn: [ x _attrs: {'glossy'. 'push'. 'text-color'->'black'. 'color'->'yellow'. 'label'->'First'. 'icon'->'verified_user'} ].
			x qBtn: [ x _attrs: {'glossy'. 'push'. 'text-color'->'black'. 'color'->'amber'. 'label'->'Second'} ].
			x qBtn: [ x _attrs: {'glossy'. 'push'. 'text-color'->'black'. 'color'->'orange'. 'label'->'Third'} ] ].
		x qBtnGroup: [
			x _attr: 'outline' set: true.
			x qBtn: [ x _attrs: {'outline'. 'color'->'brown'. 'label'->'First'} ].
			x qBtn: [ x _attrs: {'outline'. 'color'->'brown'. 'label'->'Second'. 'icon-right'->'watch_later'} ].
			x qBtn: [ x _attrs: {'outline'. 'color'->'brown'. 'label'->'Third'} ] ].
		x qBtnGroup: [
			x qBtn: [ x _attrs: {'glossy'. 'color'->'secondary'. 'label'->'First'} ].
			x qBtn: [ x _attrs: {'glossy'. 'color'->'secondary'. 'label'->'Second'} ].
			x qBtn: [ x _attrs: {'glossy'. 'color'->'secondary'. 'label'->'Third'} ].
			x qBtn: [ x _attrs: {'glossy'. 'color'->'secondary'. 'label'->'Fourth'} ] ].
		x qBtnGroup: [
			x qBtn: [ x _attrs: {'color'->'accent'. 'icon'->'timeline'} ].
			x qBtn: [ x _attrs: {'color'->'accent'. 'icon'->'visibility'} ].
			x qBtn: [ x _attrs: {'color'->'accent'. 'icon'->'update'} ] ].
		x qBtnGroup: [
			x qBtn: [ x _attrs: {'color'->'amber'. 'rounded'. 'glossy'. 'icon'->'timeline'} ].
			x qBtn: [ x _attrs: {'color'->'accent'. 'rounded'. 'glossy'. 'icon'->'visibility'} ].
			x qBtn: [ x _attrs: {'color'->'accent'. 'rounded'. 'glossy'. 'icon-right'->'update'. 'label'->'Update'} ] ] ]
]

{ #category : #rendering }
QuasarUsageComp >> renderLayoutDrawerBasic: x [

	x h4: 'LayoutDrawer Usage - Basic'.
	x div: [
		x _class: 'q-pa-md'.
		x qLayout: [
			x
				_attrs: {'view'->'hHh Lpr lff'. 'container'->true};
				_style: 'height' set: '300px';
				_class: 'shadow-2 rounded-borders'.
			x qHeader: [
				x _attrs: {'elevated'}.
				x qToolbar: [
					x qBtn: [
						x _onClick: [ drawerLeft value: "drawerLeft not" false ].
						x _attrs: {'flat'. 'round'. 'dense'. 'icon'->'menu'} ].
					x qToolbarTitle: 'Header'.
					x qBtn: [
						x _onClick: [ drawerRight value: true ].
						x _attrs: {'flat'. 'round'. 'dense'. 'icon'->'menu'} ] ] ].
			x qDrawer: [
				x
					vModel: #drawerLeft;
					_attrs: { 'show-if-above'. 'width'->200. 'breakpoint'->700. 'elevated' };
					_class: 'bg-primary text-white'.
				x qScrollArea: [
					x _class: 'fit'.
					x div: [
						x _class: 'q-pa-sm'.
						x div: [
							x _attrs: { 'v-for'->'n in 50'. ':key'->'n' }.
							x << 'Drawer {{ n }} / 50' ] ] ] ].
			x qDrawer: [
				x
					vModel: #drawerRight;
					"_attr: 'v-model' set: 'drawerRight';"
					_attrs: { 'side'->'right'. 'show-if-above'. 'bordered'. 'width'->200. 'breakpoint'->700. 'elevated' };
					_class: 'bg-primary text-white'.
				x qScrollArea: [
					x _class: 'fit'.
					x div: [
						x _class: 'q-pa-sm'.
						x div: [
							x _attrs: { 'v-for'->'n in 50'. ':key'->'n' }.
							x << 'Drawer {{ n }} / 50' ] ] ] ].
			x qPageContainer: [
				x qPage: [
					x _attrs: {'padding'}.
					15 timesRepeat: [
						x p: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit nihil praesentium molestias a adipisci, dolore vitae odit, quidem consequatur optio voluptates asperiores pariatur eos numquam rerum delectus commodi perferendis voluptate?' ] ] ] ] ]
]

{ #category : #rendering }
QuasarUsageComp >> renderLayoutPageBasic: x [

	x h4: 'LayoutPage Usage - Basic'.
	x div: [
		x _class: 'q-pa-md'.
		x qLayout: [
			x _attr: 'view' set: 'lHh lpr lFf'; _attr: 'container' set: true; _style: 'height' set: '400px'; _class: 'shadow-2 rounded-borders'.
			x qHeader: [
				x qToolbar: [
					x qAvatar: [
						x img: [ x _attr: 'src' set: 'https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg' ] ].
					x qToolbarTitle: 'Quasar Framework'.
					x qBtn: [ x _attr: 'flat' set: ''; _attr: 'round' set: ''; _attr: 'dense' set: ''; _attr: 'icon' set: 'whatshot' ] ] ].
			x qPageContainer: [
				x qPage: [
					x _attr: 'padding' set: ''.
					15 timesRepeat: [
						x p: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugit nihil praesentium molestias a adipisci, dolore vitae odit, quidem consequatur optio voluptates asperiores pariatur eos numquam rerum delectus commodi perferendis voluptate?' ] ] ] ] ]
]

{ #category : #rendering }
QuasarUsageComp >> renderVueWith: x [

	x div: [
		x div: [ self renderBtn: x ].
		x div: [ self renderBtnGroup: x ].
		x div: [ self renderBtnDropdown: x ].
		x div: [ self renderLayoutPageBasic: x ].
		x div: [ self renderLayoutDrawerBasic: x ] ]
]
