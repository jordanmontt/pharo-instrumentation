Class {
	#name : 'IPASTBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPASTBench >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'initialization' }
IPASTBench >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
