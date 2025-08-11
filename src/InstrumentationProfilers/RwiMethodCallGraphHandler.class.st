Class {
	#name : 'RwiMethodCallGraphHandler',
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
RwiMethodCallGraphHandler class >> new [

	self error: 'Use onMethod:profiler: instead'
]

{ #category : 'instance creation' }
RwiMethodCallGraphHandler class >> onMethod: aMethod profiler: aProfiler [

	^ self basicNew
		  initialize;
		  method: aMethod;
		  profiler: aProfiler;
		  yourself
]

{ #category : 'evaluating' }
RwiMethodCallGraphHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: aReturnValue [

	profiler exitingMethod.
	'after' traceCr.
	^ aReturnValue
]

{ #category : 'evaluating' }
RwiMethodCallGraphHandler >> beforeExecutionWithReceiver: aReceiverr arguments: arguments [

	profiler enteringMethod: method
]

{ #category : 'evaluating' }
RwiMethodCallGraphHandler >> method: aMethod [

	method := aMethod
]

{ #category : 'evaluating' }
RwiMethodCallGraphHandler >> profiler: aProfiler [

	profiler := aProfiler
]
