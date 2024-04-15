Class {
	#name : 'IPCompressionBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'benchmarking' }
IPCompressionBench class >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'benchmarking' }
IPCompressionBench class >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
