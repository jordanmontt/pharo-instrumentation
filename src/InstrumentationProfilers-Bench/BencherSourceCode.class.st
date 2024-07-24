Class {
	#name : 'BencherSourceCode',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'default' }
BencherSourceCode >> callGraphInstrumentator [

	^ SourceCodeCallGraphInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> methodCoverageInstrumentator [

	^ SourceCodeMethodCoverageInstrumentator new
]

{ #category : 'default' }
BencherSourceCode >> noActionInstrumentator [

	^ SourceCodeNoActionInstrumentator new
]

{ #category : 'api - profiler' }
BencherSourceCode >> useCallGraphProfiler [

	CallGraphProfiler reset.
	profiler := CallGraphProfiler defaultInstance
		instrumentator: self callGraphInstrumentator;
		methods: methodsToInstrument;
		yourself
]

{ #category : 'api - profiler' }
BencherSourceCode >> useMethodCoverageProfiler [

	MethodCoverageProfiler reset.
	profiler := MethodCoverageProfiler defaultInstance.
	profiler
		instrumentator: self methodCoverageInstrumentator;
		methods: methodsToInstrument
]

{ #category : 'api - profiler' }
BencherSourceCode >> useNoActionProfiler [

	AbstractProfiler reset.
	profiler := AbstractProfiler defaultInstance
		instrumentator: self noActionInstrumentator;
		methods: methodsToInstrument;
		yourself
]
