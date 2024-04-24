Class {
	#name : 'IPRunAbstractBench',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench-Run-All',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Run-All'
}

{ #category : 'initialization' }
IPRunAbstractBench >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'initialization' }
IPRunAbstractBench >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runBaseline [

	testSuites do: #run
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runSCMCallGraph [

	^ SourceCodeCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runSCMMethodCoverage [

	^ SourceCodeMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'as yet unclassified' }
IPRunAbstractBench >> runSCMNoAction [

	^ SourceCodeNoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'initialization' }
IPRunAbstractBench >> testPackages [

	^ self subclassResponsibility
]
