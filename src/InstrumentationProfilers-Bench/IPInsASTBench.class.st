Class {
	#name : 'IPInsASTBench',
	#superclass : 'IPInsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Instrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Instrumentation'
}

{ #category : 'initialization' }
IPInsASTBench >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'initialization' }
IPInsASTBench >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
