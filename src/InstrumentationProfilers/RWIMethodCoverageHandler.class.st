Class {
	#name : 'RWIMethodCoverageHandler',
	#superclass : 'RWIHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'instance creation' }
RWIMethodCoverageHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
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
