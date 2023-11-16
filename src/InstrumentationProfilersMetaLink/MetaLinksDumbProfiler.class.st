Class {
	#name : 'MetaLinksDumbProfiler',
	#superclass : 'Object',
	#instVars : [
		'beforeMetaLink',
		'afterMetaLink',
		'originalMethods',
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilersMetaLink',
	#package : 'InstrumentationProfilersMetaLink'
}

{ #category : 'adding' }
MetaLinksDumbProfiler >> addMethods: methodsCollection [

	originalMethods addAll: methodsCollection
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> enterMethod: aMethod [

	| methodNode |
	('enterMethod:' , aMethod name) traceCr.
	methodNode := StackMethodNode new
		name: aMethod name;
		sender: callStack pop;
		yourself.
	nodes add: methodNode.
	callStack push: methodNode
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> exitMethod: aMethod [

	('exitMethod:' , aMethod name) traceCr.
	callStack pop.
	"The before method is executed twice.
	See https://github.com/pharo-project/pharo/issues/15283"
	callStack pop
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> initialize [

	| aNode |
	super initialize.
	originalMethods := Set new.
	nodes := OrderedCollection new.	
	
	aNode := StackMethodNode new
			name: #root;
			yourself.
	nodes add: aNode.
	callStack := Stack new
		push: aNode;
		yourself.

	beforeMetaLink := MetaLink new
		metaObject: self;
		selector: #enterMethod:;
		arguments: #(method);
		control: #before;
		optionCompileOnLinkInstallation: true;
		yourself.
	afterMetaLink := MetaLink new
		metaObject: self;
		selector: #exitMethod:;
		arguments: #(method);
		control: #after;
		optionCompileOnLinkInstallation: true;
		yourself.
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> startProfiling [

	originalMethods do: [ :method |
		method ast link: beforeMetaLink.
		method ast body link: afterMetaLink ]
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> stopProfiling [

	originalMethods do: [ :method |
		method ast removeLink: beforeMetaLink.
		method ast body removeLink: afterMetaLink.
		beforeMetaLink uninstall.
		afterMetaLink uninstall ]
]
