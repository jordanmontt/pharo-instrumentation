Class {
	#name : 'MpAbstractInstrumentator',
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
MpAbstractInstrumentator class >> new [

	^ self error: 'Use onProfiler: instead of new'
]

{ #category : 'as yet unclassified' }
MpAbstractInstrumentator class >> onProfiler: aProfiler [

	^ self basicNew
		  initialize;
		  profiler: aProfiler;
		  yourself
]

{ #category : 'initialization' }
MpAbstractInstrumentator >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'profiling' }
MpAbstractInstrumentator >> instrument [

	methodProxies valuesDo: #install
]

{ #category : 'accessing' }
MpAbstractInstrumentator >> methodProxies [
	^ methodProxies
]

{ #category : 'accessing' }
MpAbstractInstrumentator >> methods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method |
			methodProxies
				at: method
				put: (self newMethodProxy: method) ]
]

{ #category : 'accessing' }
MpAbstractInstrumentator >> newHandler: aMethod [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MpAbstractInstrumentator >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'accessing' }
MpAbstractInstrumentator >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'profiling' }
MpAbstractInstrumentator >> uninstrument [

	methodProxies valuesDo: #uninstall
]
