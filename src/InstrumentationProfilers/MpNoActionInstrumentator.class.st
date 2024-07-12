Class {
	#name : 'MpNoActionInstrumentator',
	#superclass : 'MpAbstractInstrumentator',
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'accessing' }
MpNoActionInstrumentator >> newHandler: aMethod [

	^ MpNoActionHandler new
]
