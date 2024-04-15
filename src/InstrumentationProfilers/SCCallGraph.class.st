Class {
	#name : 'SCCallGraph',
	#superclass : 'Object',
	#instVars : [
		'callStack',
		'nodes'
	],
	#classVars : [
		'Instance'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'accessing' }
SCCallGraph class >> default [

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : 'class initialization' }
SCCallGraph class >> reset [

	Instance := self new
]

{ #category : 'initialization' }
SCCallGraph >> callStack [

	^ callStack
]

{ #category : 'initialization' }
SCCallGraph >> enteringMethod: aMethodSignature [

	| node callerNode |
	('entering method ', aMethodSignature name) traceCr.
	callStack ensureStackIsInitialized.
	callerNode := callStack top.
	node := self nodeForMethod: aMethodSignature.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'initialization' }
SCCallGraph >> exitingMethod [

	callStack pop.
	'exit' traceCr
]

{ #category : 'initialization' }
SCCallGraph >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'initialization' }
SCCallGraph >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'initialization' }
SCCallGraph >> nodes [

	^ nodes
]

{ #category : 'initialization' }
SCCallGraph >> rootNode [

	| rootNode |
	rootNode := CallGraphMethodNode forMethod: #root.
	nodes at: #root put: rootNode.
	^ rootNode
]
