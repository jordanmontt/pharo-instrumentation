Class {
	#name : 'MpNoActionInstrumentator',
	#superclass : 'MpInstrumentator',
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'accessing' }
MpNoActionInstrumentator >> newHandler: aMethod [

	^ MpNoActionHandler new
]
