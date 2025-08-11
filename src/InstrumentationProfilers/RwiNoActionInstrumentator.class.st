Class {
	#name : 'RwiNoActionInstrumentator',
	#superclass : 'RwiInstrumentator',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'accessing' }
RwiNoActionInstrumentator >> newHandler: aMethod [

	^ RWINoActionHandler new
]
