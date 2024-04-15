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

{ #category : 'accessing' }
IPAbstractBench class >> methodsToInstrument [

	^ methodsToInstrument
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

{ #category : 'benchmarking' }
IPAbstractBench >> runBaseline [

	self class testSuites do: #run
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpCallGraph [

	^ MpCallGraphProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpMethodCoverage [

	^ MpMethodCoverageProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runMpNoAction [

	^ MpNoActionProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWICallGraph [

	^ RWICallGraphProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWIMethodCoverage [

	^ RWIMethodCoverageProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]

{ #category : 'benchmarking' }
IPAbstractBench >> runRWINoAction [

	^ RWINoActionProfiler new
		addMethods: self class methodsToInstrument;
		profile: [ self runBaseline ];
		yourself
]
