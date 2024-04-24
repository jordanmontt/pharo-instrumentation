Class {
	#name : 'IPUninsAbstractBench',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench-Uninstrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Uninstrumentation'
}

{ #category : 'initialization' }
IPUninsAbstractBench >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'initialization' }
IPUninsAbstractBench >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		  addMethods: methodsToInstrument;
		  uninstrument;
		  yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runSCMCallGraph [

	^ SourceCodeCallGraphProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runSCMMethodCoverage [

	^ SourceCodeMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPUninsAbstractBench >> runSCMNoAction [

	^ SourceCodeNoActionProfiler new
		addMethods: methodsToInstrument;
		uninstrument;
		yourself
]

{ #category : 'initialization' }
IPUninsAbstractBench >> testPackages [

	^ self subclassResponsibility
]
