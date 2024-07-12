Class {
	#name : 'RwiInstrumentator',
	#superclass : 'Object',
	#instVars : [
		'methodProxies',
		'profiler'
	],
	#category : 'InstrumentationProfilers-RWI',
	#package : 'InstrumentationProfilers',
	#tag : 'RWI'
}

{ #category : 'as yet unclassified' }
RwiInstrumentator class >> onProfiler: aProfiler [

	^ self new
		profiler: aProfiler;
		yourself
]

{ #category : 'initialization' }
RwiInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
RwiInstrumentator >> instrument [

	methodProxies valuesDo: #install
]

{ #category : 'accessing' }
RwiInstrumentator >> methodProxies [
	^ methodProxies
]

{ #category : 'accessing' }
RwiInstrumentator >> methods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method |
			methodProxies
				at: method
				put: (self newMethodProxy: method) ]
]

{ #category : 'as yet unclassified' }
RwiInstrumentator >> newHandler: aMethod [ 
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RwiInstrumentator >> newMethodProxy: aMethod [

	^ RWIMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'accessing' }
RwiInstrumentator >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'profiling' }
RwiInstrumentator >> uninstrument [

	methodProxies valuesDo: #uninstall
]
