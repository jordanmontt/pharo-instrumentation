Class {
	#name : 'SourceCodeNoActionInstrumentator',
	#superclass : 'SourceCodeInstrumentator',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'initialization' }
SourceCodeNoActionInstrumentator >> initialize [

	super initialize.
	self beforeAction: [ "do nothing" ].
	self afterAction: [ "do nothing" ]
]
