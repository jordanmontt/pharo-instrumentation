Class {
	#name : 'IPExeASTBench',
	#superclass : 'IPExeAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Execute',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Execute'
}

{ #category : 'initialization' }
IPExeASTBench >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'initialization' }
IPExeASTBench >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
