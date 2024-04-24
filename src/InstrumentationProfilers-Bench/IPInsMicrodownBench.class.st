Class {
	#name : 'IPInsMicrodownBench',
	#superclass : 'IPInsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Instrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Instrumentation'
}

{ #category : 'initialization' }
IPInsMicrodownBench >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'initialization' }
IPInsMicrodownBench >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
