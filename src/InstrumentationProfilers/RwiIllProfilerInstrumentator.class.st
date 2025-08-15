Class {
	#name : 'RwiIllProfilerInstrumentator',
	#superclass : 'RwiInstrumentator',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'accessing' }
RwiIllProfilerInstrumentator >> newHandler: aMethod [

	^ RwiIllHandler new profiler: profiler; yourself
]
