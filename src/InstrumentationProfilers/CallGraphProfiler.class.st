Class {
	#name : 'CallGraphProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'accessing' }
CallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'initialization' }
CallGraphProfiler >> enteringMethod: aMethod [

	| node callerNode |
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'initialization' }
CallGraphProfiler >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
CallGraphProfiler >> initialize [

	super initialize.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack new
		profiler: self;
		ensureStackIsInitialized;
		yourself
]

{ #category : 'accessing' }
CallGraphProfiler >> instrumentator [

	^ instrumentator
]

{ #category : 'initialization' }
CallGraphProfiler >> nodeForMethod: method [

	^ nodes at: method
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
CallGraphProfiler >> nodes [

	^ nodes
]

{ #category : 'private' }
CallGraphProfiler >> rootNode [

	^ nodes
		at: #root
		ifAbsentPut: [ CallGraphMethodNode forMethod: #root ]
]
