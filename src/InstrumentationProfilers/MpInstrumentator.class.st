Class {
	#name : 'MpInstrumentator',
	#superclass : 'Object',
	#instVars : [
		'methodProxies',
		'profiler'
	],
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'as yet unclassified' }
MpInstrumentator class >> onProfiler: aProfiler [

	^ self new
		profiler: aProfiler;
		yourself
]

{ #category : 'initialization' }
MpInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
MpInstrumentator >> instrument [

	methodProxies valuesDo: #install
]

{ #category : 'accessing' }
MpInstrumentator >> methodProxies [
	^ methodProxies
]

{ #category : 'accessing' }
MpInstrumentator >> methods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method |
			methodProxies
				at: method
				put: (self newMethodProxy: method) ]
]

{ #category : 'accessing' }
MpInstrumentator >> newHandler: aMethod [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MpInstrumentator >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'accessing' }
MpInstrumentator >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'profiling' }
MpInstrumentator >> uninstrument [

	methodProxies valuesDo: #uninstall
]
