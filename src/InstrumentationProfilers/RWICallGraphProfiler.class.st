Class {
	#name : 'RWICallGraphProfiler',
	#superclass : 'AbstractCallGraphProfiler',
	#category : 'InstrumentationProfilers-RunWithIn',
	#package : 'InstrumentationProfilers',
	#tag : 'RunWithIn'
}

{ #category : 'configuration' }
RWICallGraphProfiler >> newHandler: aMethod [

	^ RWICallGraphHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
RWICallGraphProfiler >> newMethodProxy: aMethod [

	^ RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
