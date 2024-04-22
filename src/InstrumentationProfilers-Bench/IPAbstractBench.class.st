Class {
	#name : 'IPAbstractBench',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'testSuites'
	],
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPAbstractBench >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'initialization' }
IPAbstractBench >> packagesToInstrument [

	^ self subclassResponsibility
]

{ #category : 'benchmarking' }
IPAbstractBench >> runBaseline [

	testSuites do: #run
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runSCMCallGraph [

	^ SourceCodeCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runSCMMethodCoverage [

	^ SourceCodeMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'initialization' }
IPAbstractBench >> testPackages [

	^ self subclassResponsibility
]
