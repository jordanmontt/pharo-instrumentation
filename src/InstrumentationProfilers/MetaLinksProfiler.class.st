Class {
	#name : 'MetaLinksProfiler',
	#superclass : 'Object',
	#instVars : [
		'executedMethods',
		'beforeMetaLink',
		'afterMetaLink',
		'result',
		'callStack',
		'originalMethods'
	],
	#category : 'InstrumentationProfilers-MetaLink',
	#package : 'InstrumentationProfilers',
	#tag : 'MetaLink'
}

{ #category : 'adding' }
MetaLinksProfiler >> addMethod: aMethod [

	originalMethods add: aMethod
]

{ #category : 'adding' }
MetaLinksProfiler >> addMethods: methodsCollection [

	methodsCollection do: [ :method | self addMethod: method ]
]

{ #category : 'initialization' }
MetaLinksProfiler >> enterMethod: aMethod [

	| node precedingNode |
	callStack ensureStackIsInitialized.
	precedingNode := callStack top.
	node := result
		        nodeForMethod: aMethod
		        withPrecedingNode: precedingNode.
	precedingNode addCallTo: node.
	node addCall.
	callStack push: node.
	node enteringNode
]

{ #category : 'initialization' }
MetaLinksProfiler >> exitMethod: aMethod [

	callStack pop exitingNode
]

{ #category : 'initialization' }
MetaLinksProfiler >> initialize [

	super initialize.
	originalMethods := Set new.
	executedMethods := Set new.
	result := PrfMethodProfilerResult new.
	callStack := PrfProcessCallStack newWithRunner: self.

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
MetaLinksProfiler >> profile: aBlock [

	result mainProcess: thisProcess.
	self startProfiling.
	aBlock ensure: [ self stopProfiling ].
	result buildCallGraph.
	^ result 
]

{ #category : 'adding' }
MetaLinksProfiler >> startProfiling [

	result methods: originalMethods.
	originalMethods do: [ :method |
		method ast
			link: beforeMetaLink;
			link: afterMetaLink ].
	result rootNode enteringNode
]

{ #category : 'adding' }
MetaLinksProfiler >> stopProfiling [

	result rootNode exitingNode.
	originalMethods do: [ :method |
		method ast
			removeLink: beforeMetaLink;
			removeLink: afterMetaLink.
		beforeMetaLink uninstall.
		afterMetaLink uninstall ]
]
