Class {
	#name : 'AbstractProfiler',
	#superclass : 'Object',
	#instVars : [
		'instrumentator'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'accessing' }
AbstractProfiler class >> defaultInstance [

	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : 'class initialization' }
AbstractProfiler class >> reset [

	defaultInstance := nil
]

{ #category : 'profiling' }
AbstractProfiler >> instrument [

	instrumentator instrument
]

{ #category : 'profiling' }
AbstractProfiler >> instrumentator: anObject [

	instrumentator := anObject
]

{ #category : 'api' }
AbstractProfiler >> methods: aSetOfMethods [

	instrumentator methods: aSetOfMethods
]

{ #category : 'profiling' }
AbstractProfiler >> profile: aBlock [

	self startProfiling.
	^ aBlock ensure: [ self stopProfiling ]
]

{ #category : 'profiling' }
AbstractProfiler >> startProfiling [

	self instrument
]

{ #category : 'profiling' }
AbstractProfiler >> stopProfiling [

	self uninstrument
]

{ #category : 'profiling' }
AbstractProfiler >> uninstrument [

	instrumentator uninstrument
]
