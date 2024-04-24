Class {
	#name : 'SourceCodeNoActionProfiler',
	#superclass : 'SourceCodeModificatorProfiler',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeNoActionProfiler >> initialize [

	super initialize.
	self beforeAction: [ "do nothing" ].
	self afterAction: [ "do nothing" ]
]
