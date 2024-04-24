Class {
	#name : 'IPExeCompressionBench',
	#superclass : 'IPExeAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Execute',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Execute'
}

{ #category : 'initialization' }
IPExeCompressionBench >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'initialization' }
IPExeCompressionBench >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
