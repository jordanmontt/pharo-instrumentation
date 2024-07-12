Class {
	#name : 'BencherMp',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherMp >> callGraphInstrumentator [

	^ MpCallGraphInstrumentator new
]

{ #category : 'default' }
BencherMp >> methodCoverageInstrumentator [

	^ MpMethodCoverageInstrumentator new
]

{ #category : 'default' }
BencherMp >> noActionInstrumentator [

	^ MpNoActionInstrumentator new
]
