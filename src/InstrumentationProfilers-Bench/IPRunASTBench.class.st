Class {
	#name : 'IPRunASTBench',
	#superclass : 'IPRunAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Run-All',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Run-All'
}

{ #category : 'initialization' }
IPRunASTBench >> packagesToInstrument [

	^ { 'AST-Core' asPackage }
]

{ #category : 'initialization' }
IPRunASTBench >> testPackages [

	^ { 'AST-Core-Tests' asPackage }
]
