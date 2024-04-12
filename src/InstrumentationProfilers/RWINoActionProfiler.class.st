Class {
	#name : 'RWINoActionProfiler',
	#superclass : 'AbstractProfiler',
	#category : 'InstrumentationProfilers-No-Action',
	#package : 'InstrumentationProfilers',
	#tag : 'No-Action'
}

{ #category : 'configuration' }
RWINoActionProfiler >> newHandler: aMethod [

	^ RWINoActionHandler new
]

{ #category : 'configuration' }
RWINoActionProfiler >> newMethodProxy: aMethod [

	^RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
