Class {
	#name : 'RwiNoActionInstrumentator',
	#superclass : 'RwiInstrumentator',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'as yet unclassified' }
RwiNoActionInstrumentator >> newHandler: aMethod [

	^ RWINoActionHandler new
]
