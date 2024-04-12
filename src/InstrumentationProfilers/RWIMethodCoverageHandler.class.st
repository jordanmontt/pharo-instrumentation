Class {
	#name : 'RWIMethodCoverageHandler',
	#superclass : 'RWIHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'instance creation' }
RWIMethodCoverageHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler
		yourself
]

{ #category : 'evaluating' }
RWIMethodCoverageHandler >> beforeMethod [

	profiler callingMethod: method
]

{ #category : 'accessing' }
RWIMethodCoverageHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
RWIMethodCoverageHandler >> profiler: aProfiler [

	profiler := aProfiler
]
