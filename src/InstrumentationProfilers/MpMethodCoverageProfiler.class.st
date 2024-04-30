Class {
	#name : 'MpMethodCoverageProfiler',
	#superclass : 'AbstractMethodCoverageProfiler',
	#category : 'InstrumentationProfilers-Trap-Method',
	#package : 'InstrumentationProfilers',
	#tag : 'Trap-Method'
}

{ #category : 'configuration' }
MpMethodCoverageProfiler >> newHandler: aMethod [

	^ MpMethodCoverageHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
MpMethodCoverageProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
