Class {
	#name : 'MpMethodCoverageProfiler',
	#superclass : 'AbstractMethodCoverageProfiler',
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'configuration' }
MpMethodCoverageProfiler >> newHandler: aMethod [

	^ MpMethodCoverageHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
MpMethodCoverageProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
