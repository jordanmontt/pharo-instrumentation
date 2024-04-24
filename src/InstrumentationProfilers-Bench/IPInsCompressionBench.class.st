Class {
	#name : 'IPInsCompressionBench',
	#superclass : 'IPInsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Instrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Instrumentation'
}

{ #category : 'initialization' }
IPInsCompressionBench >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'initialization' }
IPInsCompressionBench >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
