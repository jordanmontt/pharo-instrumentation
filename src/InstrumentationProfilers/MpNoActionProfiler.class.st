Class {
	#name : 'MpNoActionProfiler',
	#superclass : 'AbstractProfiler',
	#category : 'InstrumentationProfilers-Trap-Method',
	#package : 'InstrumentationProfilers',
	#tag : 'Trap-Method'
}

{ #category : 'configuration' }
MpNoActionProfiler >> newHandler: aMethod [

	^ MpNoActionHandler new
]

{ #category : 'configuration' }
MpNoActionProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
