Class {
	#name : 'IPRunCompressionBench',
	#superclass : 'IPRunAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Run-All',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Run-All'
}

{ #category : 'initialization' }
IPRunCompressionBench >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'initialization' }
IPRunCompressionBench >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
