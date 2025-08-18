Class {
	#name : 'BencherMp',
	#superclass : 'Bencher',
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'api - profiler' }
BencherMp >> useAllocationCallGraphProfiler [

	profiler := IllAllocationCallGraphProfiler new
]

{ #category : 'api - profiler' }
BencherMp >> useAllocationRateProfiler [

	profiler := IllAllocationRateProfiler new
]

{ #category : 'api - profiler' }
BencherMp >> useMethodCallGraphProfiler [

	profiler := MethodCallGraphProfiler new
		methodsToInstrument: methodsToInstrument;
		yourself
]

{ #category : 'api - profiler' }
BencherMp >> useNoActionProfiler [

	profiler := MethodCallGraphProfiler new
			instrumentator: MCGMpInstrumentatorNoAction new;
			methodsToInstrument: methodsToInstrument;
		   	yourself
]
