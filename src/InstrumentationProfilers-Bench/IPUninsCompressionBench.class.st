Class {
	#name : 'IPUninsCompressionBench',
	#superclass : 'IPUninsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Uninstrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Uninstrumentation'
}

{ #category : 'initialization' }
IPUninsCompressionBench >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'initialization' }
IPUninsCompressionBench >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
