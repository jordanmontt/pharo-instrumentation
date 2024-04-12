Class {
	#name : 'MpNoActionProfiler',
	#superclass : 'AbstractProfiler',
	#category : 'InstrumentationProfilers-No-Action',
	#package : 'InstrumentationProfilers',
	#tag : 'No-Action'
}

{ #category : 'configuration' }
MpNoActionProfiler >> newHandler: aMethod [

	^ MpNoActionHandler new
]

{ #category : 'configuration' }
MpNoActionProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
