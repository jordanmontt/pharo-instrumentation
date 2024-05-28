Class {
	#name : 'RWIMethodCoverageProfiler',
	#superclass : 'AbstractMethodCoverageProfiler',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'configuration' }
RWIMethodCoverageProfiler >> newHandler: aMethod [

	^ RWIMethodCoverageHandler onMethod: aMethod nameForProfiler profiler: self
]

{ #category : 'configuration' }
RWIMethodCoverageProfiler >> newMethodProxy: aMethod [

	^ RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
