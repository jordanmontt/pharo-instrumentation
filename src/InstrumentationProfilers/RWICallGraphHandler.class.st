Class {
	#name : 'RWICallGraphHandler',
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
RWICallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
RWICallGraphHandler >> afterMethod [

	profiler exitingMethod
]

{ #category : 'evaluating' }
RWICallGraphHandler >> beforeMethod [

	profiler enteringMethod: method
]

{ #category : 'evaluating' }
RWICallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'evaluating' }
RWICallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
