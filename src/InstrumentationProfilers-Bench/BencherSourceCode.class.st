Class {
	#name : 'BencherSourceCode',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherSourceCode >> callGraphInstrumentator [

	^ SourceCodeCallGraphInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> methodCoverageInstrumentator [

	^ SourceCodeMethodCoverageInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> noActionInstrumentator [

	^ SourceCodeNoActionInstrumentator new
]
