Class {
	#name : 'IPUninsASTBench',
	#superclass : 'IPUninsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Uninstrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Uninstrumentation'
}

{ #category : 'initialization' }
IPUninsASTBench >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'initialization' }
IPUninsASTBench >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
