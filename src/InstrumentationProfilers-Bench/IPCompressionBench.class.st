Class {
	#name : 'IPCompressionBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPCompressionBench >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'initialization' }
IPCompressionBench >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
