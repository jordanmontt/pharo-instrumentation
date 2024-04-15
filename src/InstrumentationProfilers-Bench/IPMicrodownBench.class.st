Class {
	#name : 'IPMicrodownBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'benchmarking' }
IPMicrodownBench class >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'benchmarking' }
IPMicrodownBench class >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
