Class {
	#name : 'Bencher',
	#superclass : 'Object',
	#instVars : [
		'profiler',
		'methodsToInstrument',
		'testSuites',
		'blockToProfile'
	],
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'api - bench' }
Bencher >> benchExecuteProfiler [

	| timeToRun |
	timeToRun := [ profiler profile: blockToProfile ] timeToRun.
	^ self formatTime: timeToRun
]

{ #category : 'api - bench' }
Bencher >> benchExecution [

	| timeToRun |
	profiler instrument.
	timeToRun := [ blockToProfile value ] timeToRun.
	profiler uninstrument.
	^ self formatTime: timeToRun
]

{ #category : 'api - bench' }
Bencher >> benchInstrument [

	| timeToRun |
	timeToRun := [ profiler instrument ] timeToRun.
	profiler uninstrument.
	^ self formatTime: timeToRun
]

{ #category : 'api - bench' }
Bencher >> benchUninstrument [

	| timeToRun |
	profiler instrument.
	timeToRun := [ profiler uninstrument ] timeToRun.
	^ self formatTime: timeToRun
]

{ #category : 'api - bench' }
Bencher >> blockToProfile: aBlock [

	blockToProfile := aBlock
]

{ #category : 'default' }
Bencher >> callGraphInstrumentator [
	^ self subclassResponsibility
]

{ #category : 'default' }
Bencher >> formatTime: timeToRun [

	^ timeToRun wholeMilliseconds
]

{ #category : 'initialization' }
Bencher >> initialize [

	super initialize
]

{ #category : 'default' }
Bencher >> methodCoverageInstrumentator [
	^ self subclassResponsibility
]

{ #category : 'api' }
Bencher >> methodsToInstrument: methods [

	methodsToInstrument := methods asSet
]

{ #category : 'default' }
Bencher >> noActionInstrumentator [
	^ self subclassResponsibility
]

{ #category : 'api' }
Bencher >> packagesToInstrument: aCollectionOrSetOfPackages [

	methodsToInstrument := aCollectionOrSetOfPackages flatCollect: #methods as: Set.
]

{ #category : 'initialization' }
Bencher >> testPackages: testPackages [

	| testClasses |
	testClasses := (testPackages flatCollect: #definedClasses as: Set)
		select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'api - profiler' }
Bencher >> useCallGraphProfiler [

	profiler := CallGraphProfiler new
		methods: methodsToInstrument;
		instrumentator: self callGraphInstrumentator;
		yourself
]

{ #category : 'api - profiler' }
Bencher >> useMethodCoverageProfiler [

	profiler := MethodCoverageProfiler new
		methods: methodsToInstrument;
		instrumentator: self methodCoverageInstrumentator;
		yourself
]

{ #category : 'api - profiler' }
Bencher >> useNoActionProfiler [

	profiler := AbstractProfiler new
		methods: methodsToInstrument;
		instrumentator: self noActionInstrumentator;
		yourself
]
