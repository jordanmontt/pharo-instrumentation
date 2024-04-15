Class {
	#name : 'IPCompressionBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'class initialization' }
IPCompressionBench class >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
]

{ #category : 'benchmarking' }
IPCompressionBench class >> packagesToInstrument [

	^ { 'Compression' asPackage }
]

{ #category : 'benchmarking' }
IPCompressionBench class >> testPackages [

	^ { 'Compression-Tests' asPackage }
]
