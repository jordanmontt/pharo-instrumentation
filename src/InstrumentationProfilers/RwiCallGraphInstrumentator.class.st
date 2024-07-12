Class {
	#name : 'RwiCallGraphInstrumentator',
	#superclass : 'RwiInstrumentator',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'accessing' }
RwiCallGraphInstrumentator >> newHandler: aMethod [

	^ RwiCallGraphHandler onMethod: aMethod nameForProfiler profiler: profiler
]
