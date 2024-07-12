Class {
	#name : 'MpCallGraphHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'profiler',
		'method'
	],
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'instance creation' }
MpCallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self new
		method: aMethod;
		profiler: aProfiler;
		yourself
]

{ #category : 'evaluating' }
MpCallGraphHandler >> afterMethod [

	profiler exitingMethod
]

{ #category : 'evaluating' }
MpCallGraphHandler >> beforeMethod [

	profiler enteringMethod: method
]

{ #category : 'accessing' }
MpCallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
MpCallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
