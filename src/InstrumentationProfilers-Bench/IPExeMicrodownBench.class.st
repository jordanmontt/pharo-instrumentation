Class {
	#name : 'IPExeMicrodownBench',
	#superclass : 'IPExeAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Execute',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Execute'
}

{ #category : 'initialization' }
IPExeMicrodownBench >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'initialization' }
IPExeMicrodownBench >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
