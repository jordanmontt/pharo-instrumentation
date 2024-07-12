Class {
	#name : 'RwiMethodCoverageInstrumentator',
	#superclass : 'RwiInstrumentator',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'instance creation' }
RwiMethodCoverageInstrumentator >> newHandler: aMethod [

	^ RWIMethodCoverageHandler onMethod: aMethod nameForProfiler profiler: self
]
