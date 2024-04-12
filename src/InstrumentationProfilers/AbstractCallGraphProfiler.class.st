Class {
	#name : 'AbstractCallGraphProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'nodes',
		'callStack'
	],
	#category : 'InstrumentationProfilers-Call-Graph',
	#package : 'InstrumentationProfilers',
	#tag : 'Call-Graph'
}

{ #category : 'accessing' }
AbstractCallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> enteringMethod: aMethod [

	| node callerNode |
	callStack ensureStackIsInitialized.
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
AbstractCallGraphProfiler >> nodes [

	^ nodes
]

{ #category : 'configuration' }
AbstractCallGraphProfiler >> rootNode [

	| rootNode |
	rootNode := CallGraphMethodNode forMethod: #root.
	nodes at: #root put: rootNode.
	^ rootNode
]
