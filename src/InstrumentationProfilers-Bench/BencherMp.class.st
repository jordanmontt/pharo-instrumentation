Class {
	#name : 'BencherMp',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherMp >> callGraphInstrumentator [

	^ MpCallGraphInstrumentator onProfiler: profiler
]

{ #category : 'default' }
BencherMp >> methodCoverageInstrumentator [

	^ MpMethodCoverageInstrumentator onProfiler: profiler
]

{ #category : 'default' }
BencherMp >> noActionInstrumentator [

	^ MpNoActionInstrumentator onProfiler: profiler
]
