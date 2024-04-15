Class {
	#name : 'IPASTBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'class initialization' }
IPASTBench class >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
]

{ #category : 'benchmarking' }
IPASTBench class >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'benchmarking' }
IPASTBench class >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
