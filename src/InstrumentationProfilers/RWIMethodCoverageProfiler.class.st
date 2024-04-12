Class {
	#name : 'RWIMethodCoverageProfiler',
	#superclass : 'AbstractMethodCoverageProfiler',
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'configuration' }
RWIMethodCoverageProfiler >> newHandler: aMethod [

	^ RWIMethodCoverageHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
RWIMethodCoverageProfiler >> newMethodProxy: aMethod [

	^ RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
