Class {
	#name : 'SourceCodeCallGraphProfiler',
	#superclass : 'SourceCodeModificatorProfiler',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeCallGraphProfiler >> initialize [

	super initialize.
	self beforeAction: [ :instrumentedMethod |
		SCCallGraph default enteringMethod: instrumentedMethod ].
	self afterAction: [ SCCallGraph default exitingMethod ]
]

{ #category : 'profiling' }
SourceCodeCallGraphProfiler >> profile: aBlock [

	SCCallGraph reset.
	super profile: aBlock
]
