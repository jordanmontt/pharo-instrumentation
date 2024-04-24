Class {
	#name : 'IPInsAbstractBench',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench-Instrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Instrumentation'
}

{ #category : 'initialization' }
IPInsAbstractBench >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'initialization' }
IPInsAbstractBench >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		  addMethods: methodsToInstrument;
		  instrument;
		  yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runSCMCallGraph [

	^ SourceCodeCallGraphProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runSCMMethodCoverage [

	^ SourceCodeMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'as yet unclassified' }
IPInsAbstractBench >> runSCMNoAction [

	^ SourceCodeNoActionProfiler new
		addMethods: methodsToInstrument;
		instrument;
		yourself
]

{ #category : 'initialization' }
IPInsAbstractBench >> testPackages [

	^ self subclassResponsibility
]
