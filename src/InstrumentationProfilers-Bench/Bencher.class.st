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

{ #category : 'api - execution' }
Bencher >> benchExecuteProfiler [
	"Returns the time that it takes to instrument, execute, and uninstrument. The three things together"

	| timeToRun |
	timeToRun := [ profiler profile: blockToProfile ] timeToRun.
	^ self formatTime: timeToRun
]

{ #category : 'api - execution' }
Bencher >> benchExecution [
	"Returns the time that it takes to execute the bench with the instrumentation.
It does not take into account the time for instumenting nor uninstrumenting"

	| timeToRun |
	profiler instrument.
	timeToRun := [ blockToProfile value ] timeToRun.
	profiler uninstrument.
	^ self formatTime: timeToRun
]

{ #category : 'api - execution' }
Bencher >> benchInstrument [
	"Returns the time that it takes to only instrument the method."

	| timeToRun |
	timeToRun := [ profiler instrument ] timeToRun.
	profiler uninstrument.
	^ self formatTime: timeToRun
]

{ #category : 'api - execution' }
Bencher >> benchUninstrument [
	"Returns the time that it takes to only uninstrument the method."

	| timeToRun |
	profiler instrument.
	timeToRun := [ profiler uninstrument ] timeToRun.
	^ self formatTime: timeToRun
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

	super initialize.
	blockToProfile := [ testSuites do: #run ]
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

{ #category : 'api' }
Bencher >> testPackages: testPackages [

	| testClasses |
	testClasses := (testPackages flatCollect: #definedClasses as: Set)
		select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite
]

{ #category : 'api - benchmarks' }
Bencher >> useASTBench [

	self testPackages: { 'AST-Core-Tests' asPackage }.
	self packagesToInstrument: { 'AST-Core' asPackage }
]

{ #category : 'api - profiler' }
Bencher >> useCallGraphProfiler [

	profiler := CallGraphProfiler new
		instrumentator: self callGraphInstrumentator;
		methods: methodsToInstrument;
		yourself
]

{ #category : 'api - benchmarks' }
Bencher >> useCompressionBench [

	self testPackages: { 'Compression-Tests' asPackage }.
	self packagesToInstrument: { 'Compression' asPackage }
]

{ #category : 'api - benchmarks' }
Bencher >> useFileSystemBench [

	self testPackages:{
		  #'FileSystem-Memory-Tests' asPackage.
		  #'FileSystem-Core-Tests' asPackage.
		  #'FileSystem-Disk-Tests' asPackage.
		  #'FileSystem-Tests-Attributes' asPackage.
		  'Files-Tests' asPackage }.
	self packagesToInstrument: {
		  #'FileSystem-Core' asPackage.
		  #'FileSystem-Zip' asPackage.
		  #'FileSystem-Memory' asPackage.
		  #'FileSystem-Path' asPackage.
		  #'FileSystem-Disk' asPackage.
		  'Files' asPackage }
]

{ #category : 'api - profiler' }
Bencher >> useMethodCoverageProfiler [

	profiler := MethodCoverageProfiler new.
	profiler
		instrumentator: self methodCoverageInstrumentator;
		methods: methodsToInstrument
]

{ #category : 'api - benchmarks' }
Bencher >> useMicrodownBench [

	self testPackages: { 'Microdown-Tests' asPackage }.
	self packagesToInstrument: {
			'Microdown' asPackage.
			'Microdown-RichTextComposer' asPackage }
]

{ #category : 'api - profiler' }
Bencher >> useNoActionProfiler [

	profiler := AbstractProfiler new
		instrumentator: self noActionInstrumentator;
		methods: methodsToInstrument;
		yourself
]
