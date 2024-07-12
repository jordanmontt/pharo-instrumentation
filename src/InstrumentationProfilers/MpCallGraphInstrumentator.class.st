Class {
	#name : 'MpCallGraphInstrumentator',
	#superclass : 'MpAbstractInstrumentator',
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'accessing' }
MpCallGraphInstrumentator >> newHandler: aMethod [

	^ MpCallGraphHandler onMethod: aMethod nameForProfiler profiler: profiler
]
