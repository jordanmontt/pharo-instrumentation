Class {
	#name : 'IPExeAbstractBench',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench-Execute',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Execute'
}

{ #category : 'initialization' }
IPExeAbstractBench >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'initialization' }
IPExeAbstractBench >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
IPExeAbstractBench >> runBaseline [

	testSuites do: #run
]

{ #category : 'initialization' }
IPExeAbstractBench >> testPackages [

	^ self subclassResponsibility
]
