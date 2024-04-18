Trait {
	#name : 'TCallGraphBuilder',
	#instVars : [
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'accessing' }
TCallGraphBuilder >> callStack [

	^ callStack
]

{ #category : 'initialization' }
TCallGraphBuilder >> enteringMethod: aMethod [

	| node callerNode |
	callStack ensureStackIsInitialized.
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'initialization' }
TCallGraphBuilder >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
TCallGraphBuilder >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'initialization' }
TCallGraphBuilder >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
TCallGraphBuilder >> nodes [

	^ nodes
]

{ #category : 'private' }
TCallGraphBuilder >> rootNode [

	| rootNode |
	rootNode := CallGraphMethodNode forMethod: #root.
	nodes at: #root put: rootNode.
	^ rootNode
]
