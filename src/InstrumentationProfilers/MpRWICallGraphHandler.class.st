Class {
	#name : 'MpRWICallGraphHandler',
	#superclass : 'MpRWIHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'instance creation' }
MpRWICallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler
		yourself
]

{ #category : 'evaluating' }
MpRWICallGraphHandler >> afterMethod [

	profiler exitingMethod
]

{ #category : 'evaluating' }
MpRWICallGraphHandler >> beforeMethod [

	profiler enteringMethod: method
]

{ #category : 'evaluating' }
MpRWICallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'evaluating' }
MpRWICallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
