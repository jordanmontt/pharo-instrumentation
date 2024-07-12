Class {
	#name : 'SourceCodeMethodCoverageInstrumentator',
	#superclass : 'SourceCodeInstrumentator',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeMethodCoverageInstrumentator >> initialize [

	super initialize.
	self beforeAction: [ :instrumentedMethod | MethodCoverageProfiler defaultInstance callingMethod: instrumentedMethod ].
	self afterAction: [ "do nothing" ]
]

{ #category : 'initialization' }
SourceCodeMethodCoverageInstrumentator >> reset [

	MethodCoverageProfiler reset
]
