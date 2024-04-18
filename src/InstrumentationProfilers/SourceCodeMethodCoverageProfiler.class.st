Class {
	#name : 'SourceCodeMethodCoverageProfiler',
	#superclass : 'SourceCodeModificatorProfiler',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeMethodCoverageProfiler >> initialize [

	super initialize.
	self beforeAction: [ :instrumentedMethod |
		SCMethodCoverage default callingMethod: instrumentedMethod ].
	self afterAction: [ "do nothing" ]
]

{ #category : 'profiling' }
SourceCodeMethodCoverageProfiler >> profile: aBlock [

	SCMethodCoverage reset.
	super profile: aBlock
]
