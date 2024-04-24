Class {
	#name : 'IPRunMicrodownBench',
	#superclass : 'IPRunAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Run-All',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Run-All'
}

{ #category : 'initialization' }
IPRunMicrodownBench >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'initialization' }
IPRunMicrodownBench >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
