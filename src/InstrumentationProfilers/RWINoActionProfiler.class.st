Class {
	#name : 'RWINoActionProfiler',
	#superclass : 'AbstractProfiler',
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'configuration' }
RWINoActionProfiler >> newHandler: aMethod [

	^ RWINoActionHandler new
]

{ #category : 'configuration' }
RWINoActionProfiler >> newMethodProxy: aMethod [

	^RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
