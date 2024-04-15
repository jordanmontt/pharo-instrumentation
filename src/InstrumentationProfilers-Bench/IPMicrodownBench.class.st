Class {
	#name : 'IPMicrodownBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'class initialization' }
IPMicrodownBench class >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
]

{ #category : 'benchmarking' }
IPMicrodownBench class >> packagesToInstrument [

	^ {
		  'Microdown' asPackage.
		  'Microdown-RichTextComposer' asPackage }
]

{ #category : 'benchmarking' }
IPMicrodownBench class >> testPackages [

	^ { 'Microdown-Tests' asPackage }
]
