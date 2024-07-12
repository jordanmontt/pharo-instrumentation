Class {
	#name : 'BencherRwi',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherRwi >> callGraphInstrumentator [

	^ RwiCallGraphInstrumentator new
]

{ #category : 'default' }
BencherRwi >> methodCoverageInstrumentator [

	^ RwiMethodCoverageInstrumentator new
]

{ #category : 'default' }
BencherRwi >> noActionInstrumentator [

	^ RwiNoActionInstrumentator new
]
