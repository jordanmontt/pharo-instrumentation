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

{ #category : 'baseline' }
IPAbstractBench >> runBaseline [

	testSuites do: #run
]

{ #category : 'mp' }
IPAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'mp' }
IPAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'mp' }
IPAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'rwi' }
IPAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'rwi' }
IPAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'rwi' }
IPAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'scm' }
IPAbstractBench >> runSCMCallGraph [

	^ SourceCodeCallGraphProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'scm' }
IPAbstractBench >> runSCMMethodCoverage [

	^ SourceCodeMethodCoverageProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'scm' }
IPAbstractBench >> runSCMNoAction [

	^ SourceCodeNoActionProfiler new
		addMethods: methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'initialization' }
IPAbstractBench >> testPackages [

	^ self subclassResponsibility
]
