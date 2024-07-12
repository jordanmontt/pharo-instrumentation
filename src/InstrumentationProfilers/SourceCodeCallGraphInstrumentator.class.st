Class {
	#name : 'SourceCodeCallGraphInstrumentator',
	#superclass : 'SourceCodeInstrumentator',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeCallGraphInstrumentator >> initialize [

	super initialize.
	
	self beforeAction: [ :instrumentedMethod | CallGraphProfiler defaultInstance enteringMethod: instrumentedMethod ].
	self afterAction: [ CallGraphProfiler defaultInstance exitingMethod ]
]

{ #category : 'initialization' }
SourceCodeCallGraphInstrumentator >> reset [

	CallGraphProfiler reset
]
