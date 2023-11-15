Class {
	#name : 'MPCallGraphHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'instance creation' }
MPCallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler
		yourself
]

{ #category : 'evaluating' }
MPCallGraphHandler >> afterMethod [

	profiler callStack pop
]

{ #category : 'evaluating' }
MPCallGraphHandler >> beforeMethod [

	| node callerNode |
	profiler callStack ensureStackIsInitialized.
	callerNode := profiler callStack top.
	node := profiler nodeForMethod: method.
	node addCall.
	callerNode addCallTo: node.
	profiler callStack push: node.
	"profiler callStack ensureStackIsInitialized.
	callerNode := profiler callStack top.
	node := profiler nodeForMethod: method.
	callerNode addCallTo: node.
	node addCall.
	profiler callStack push: node"
]

{ #category : 'accessing' }
MPCallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MPCallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
