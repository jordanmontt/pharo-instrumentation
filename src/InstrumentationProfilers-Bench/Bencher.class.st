Class {
	#name : 'Bencher',
	#superclass : 'Object',
	#instVars : [
		'profiler',
		'methodsToInstrument',
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
	timeToRun := [ profiler profileOn: blockToProfile ] timeToRun.
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
Bencher >> formatTime: timeToRun [

	^ timeToRun wholeMilliseconds
]

{ #category : 'initialization' }
Bencher >> initialize [

	super initialize.
	blockToProfile := [ ]
]

{ #category : 'api' }
Bencher >> methodsToInstrument: methods [

	methodsToInstrument := methods asSet
]

{ #category : 'api' }
Bencher >> packagesToInstrument: aCollectionOrSetOfPackages [

	methodsToInstrument := aCollectionOrSetOfPackages flatCollect: #methods as: Set.
]

{ #category : 'api - profiler' }
Bencher >> useAllocationCallGraphProfiler [

	self subclassResponsibility
]

{ #category : 'api - profiler' }
Bencher >> useAllocationRateProfiler [

	self subclassResponsibility
]

{ #category : 'api - benchmarks' }
Bencher >> useDataFrameBench [

	self packagesToInstrument: VeritasDataFrame applicationPackages.
	blockToProfile := [ VeritasDataFrame new run ]
]

{ #category : 'api - profiler' }
Bencher >> useMethodCallGraphProfiler [

	self subclassResponsibility
]

{ #category : 'api - benchmarks' }
Bencher >> useMicrodownBench [

	"self testPackages: { 'Microdown-Tests' asPackage }.
	self packagesToInstrument: {
			'Microdown' asPackage.
			'Microdown-RichTextComposer' asPackage }"
]

{ #category : 'api - profiler' }
Bencher >> useNoActionProfiler [

	self subclassResponsibility
]
