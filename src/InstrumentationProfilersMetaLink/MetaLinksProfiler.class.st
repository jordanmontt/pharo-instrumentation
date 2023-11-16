"
```st
| testClasses testSuites methods profiler |
testClasses :=  'AI-Algorithms-Graph-Tests' asPackage definedClasses select: [ :e | e isTestCase ].
testSuites := testClasses collect: #suite.

methods := 'AI-Algorithms-Graph' asPackage methods , 'AI-Algorithms-Graph-Components' asPackage methods.
methods := methods asSet.

""profiler := MetaLinksProfiler new.""
profiler := MetaLinksDumbProfiler new. 
""profiler :=  PrfMethodProfiler new
	useRunWithIn;
	yorself""
profiler addMethods: methods.

profiler profile: [ testSuites do: #run ].
profiler
```
"
Class {
	#name : 'MetaLinksProfiler',
	#superclass : 'Object',
	#instVars : [
		'beforeMetaLink',
		'afterMetaLink',
		'result',
		'callStack',
		'originalMethods'
	],
	#category : 'InstrumentationProfilersMetaLink',
	#package : 'InstrumentationProfilersMetaLink'
}

{ #category : 'adding' }
MetaLinksProfiler >> addMethods: methodsCollection [

	originalMethods addAll: methodsCollection.
	result methods: originalMethods
]

{ #category : 'initialization' }
MetaLinksProfiler >> enterMethod: aMethod [

	| node precedingNode |
	callStack ensureStackIsInitialized.
	precedingNode := callStack top.
	node := result nodeForMethod: aMethod withPrecedingNode: precedingNode.
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
