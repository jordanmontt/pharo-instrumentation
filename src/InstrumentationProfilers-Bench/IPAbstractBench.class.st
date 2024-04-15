Class {
	#name : 'IPAbstractBench',
	#superclass : 'Object',
	#classInstVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'class initialization' }
IPAbstractBench class >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite. 
]

{ #category : 'benchmarking' }
IPAbstractBench class >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'benchmarking' }
IPAbstractBench class >> testPackages [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
IPAbstractBench class >> testSuites [

	^ testSuites
]

{ #category : 'as yet unclassified' }
IPAbstractBench >> run [

	self class testSuites do: #run
]
