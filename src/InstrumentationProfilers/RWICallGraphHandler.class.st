Class {
	#name : 'RwiCallGraphHandler',
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
RwiCallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
RwiCallGraphHandler >> afterMethod [

	profiler exitingMethod
]

{ #category : 'evaluating' }
RwiCallGraphHandler >> beforeMethod [

	profiler enteringMethod: method
]

{ #category : 'evaluating' }
RwiCallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'evaluating' }
RwiCallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
