Class {
	#name : 'SourceCodeMethodCallGraphInstrumentator',
	#superclass : 'SourceCodeInstrumentator',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'class initialization' }
SourceCodeMethodCallGraphInstrumentator class >> initialize [

	Smalltalk globals
		at: #MyMethodCallGraphProfilerInstance
		put: MethodCallGraphProfiler new
]

{ #category : 'accessing' }
SourceCodeMethodCallGraphInstrumentator class >> resetProfilerDefaultInstance [

	self initialize
]

{ #category : 'initialization' }
SourceCodeMethodCallGraphInstrumentator >> initialize [

	super initialize.
	
	self beforeAction: [ :instrumentedMethod | MyMethodCallGraphProfilerInstance enteringMethod: instrumentedMethod ].
	self afterAction: [ MyMethodCallGraphProfilerInstance exitingMethod ]
]
