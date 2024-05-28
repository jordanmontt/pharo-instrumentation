Trait {
	#name : 'TCallGraphBuilder',
	#instVars : [
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'accessing' }
TCallGraphBuilder >> callStack [

	^ callStack
]

{ #category : 'initialization' }
TCallGraphBuilder >> enteringMethod: aMethod [

	| node callerNode |
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
	callStack := Stack new
		push: self rootNode;
		yourself
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
