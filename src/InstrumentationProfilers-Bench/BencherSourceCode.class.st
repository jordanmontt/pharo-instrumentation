Class {
	#name : 'BencherSourceCode',
	#superclass : 'Bencher',
	#classVars : [
		'MyAllocationCallGraphProfiler',
		'MyAllocationRateProfiler',
		'MyMethodCallGraphProfiler',
		'MyNoActionProfiler'
	],
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'as yet unclassified' }
BencherSourceCode class >> allocationCallGraphProfilerInstance [

	^ MyAllocationCallGraphProfiler ifNil: [
		  MyAllocationCallGraphProfiler := IllAllocationCallGraphProfiler new ]
]

{ #category : 'as yet unclassified' }
BencherSourceCode class >> allocationRateProfilerInstance [

	^ MyAllocationRateProfiler ifNil: [
		  MyAllocationRateProfiler := IllAllocationRateProfiler new ]
]

{ #category : 'as yet unclassified' }
BencherSourceCode class >> methodCallGraphProfilerInstance [

	^ MyMethodCallGraphProfiler ifNil: [
		  MyMethodCallGraphProfiler := MethodCallGraphProfiler new ]
]

{ #category : 'as yet unclassified' }
BencherSourceCode class >> noActionProfilerInstance [

	^ MyNoActionProfiler ifNil: [
		MyNoActionProfiler := MethodCallGraphProfiler new
				instrumentator: MCGMpInstrumentatorNoAction new;
				yourself ]
]

{ #category : 'default' }
BencherSourceCode >> callGraphInstrumentator [

	^ SourceCodeMethodCallGraphInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> methodCoverageInstrumentator [

	^ SourceCodeAllocationCallGraphInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> noActionInstrumentator [

	^ SourceCodeNoActionInstrumentator new
]

{ #category : 'api - profiler' }
BencherSourceCode >> useCallGraphProfiler [

	MyMethodCallGraphProfiler := nil.
	profiler := self class methodCallGraphProfilerInstance
]

{ #category : 'api - profiler' }
BencherSourceCode >> useNoActionProfiler [

	"AbstractProfiler reset.
	profiler := AbstractProfiler defaultInstance
		instrumentator: self noActionInstrumentator;
		methods: methodsToInstrument;
		yourself"
]
