Class {
	#name : 'MpMethodCoverageHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'instance creation' }
MpMethodCoverageHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler
		yourself
]

{ #category : 'evaluating' }
MpMethodCoverageHandler >> beforeMethod [

	profiler callingMethod: method
]

{ #category : 'evaluating' }
MpMethodCoverageHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'evaluating' }
MpMethodCoverageHandler >> profiler: aProfiler [

	profiler := aProfiler
]
