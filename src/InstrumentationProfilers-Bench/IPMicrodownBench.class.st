Class {
	#name : 'IPMicrodownBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPMicrodownBench >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'initialization' }
IPMicrodownBench >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
