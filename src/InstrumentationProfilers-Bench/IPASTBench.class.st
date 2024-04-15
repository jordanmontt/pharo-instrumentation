Class {
	#name : 'IPASTBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'benchmarking' }
IPASTBench class >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'benchmarking' }
IPASTBench class >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
