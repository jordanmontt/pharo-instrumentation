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
