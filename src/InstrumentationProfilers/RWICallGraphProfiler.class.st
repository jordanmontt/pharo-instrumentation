Class {
	#name : 'RWICallGraphProfiler',
	#superclass : 'AbstractCallGraphProfiler',
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'configuration' }
RWICallGraphProfiler >> newHandler: aMethod [

	^ MpRWICallGraphHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
RWICallGraphProfiler >> newMethodProxy: aMethod [

	^ MpRWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
