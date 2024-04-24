Class {
	#name : 'IPUninsMicrodownBench',
	#superclass : 'IPUninsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Uninstrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Uninstrumentation'
}

{ #category : 'initialization' }
IPUninsMicrodownBench >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'initialization' }
IPUninsMicrodownBench >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
