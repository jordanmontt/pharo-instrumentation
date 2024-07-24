Class {
	#name : 'BencherRwi',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherRwi >> callGraphInstrumentator [

	^ RwiCallGraphInstrumentator onProfiler: profiler
]

{ #category : 'default' }
BencherRwi >> methodCoverageInstrumentator [

	^ RwiMethodCoverageInstrumentator onProfiler: profiler
]

{ #category : 'default' }
BencherRwi >> noActionInstrumentator [

	^ RwiNoActionInstrumentator onProfiler: profiler
]
