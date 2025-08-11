Class {
	#name : 'SourceCodeAllocationCallGraphInstrumentator',
	#superclass : 'SourceCodeInstrumentator',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeAllocationCallGraphInstrumentator >> initialize [

	super initialize.
	self beforeAction: [ :instrumentedMethod | MyAllocationCallGraphProfilerInstance callingMethod: instrumentedMethod ].
	self afterAction: [ "do nothing" ]
]
