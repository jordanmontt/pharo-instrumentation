Class {
	#name : 'MpMethodCoverageInstrumentator',
	#superclass : 'MpAbstractInstrumentator',
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'accessing' }
MpMethodCoverageInstrumentator >> newHandler: aMethod [

	^ MpMethodCoverageHandler onMethod: aMethod nameForProfiler profiler: self
]
