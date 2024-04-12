Class {
	#name : 'AbstractProfiler',
	#superclass : 'Object',
	#instVars : [
		'methodProxies'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'api' }
AbstractProfiler >> addMethod: aMethod [

	methodProxies
		at: aMethod
		put: (self newMethodProxy: aMethod)
]

{ #category : 'api' }
AbstractProfiler >> addMethods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method | self addMethod: method ]
]

{ #category : 'initialization' }
AbstractProfiler >> initialize [

	super initialize.
	methodProxies := Dictionary new
]

{ #category : 'accessing' }
AbstractProfiler >> methodProxies [

	^ methodProxies
]

{ #category : 'configuration' }
AbstractProfiler >> newHandler: aMethod [ 
	^ self subclassResponsibility
]

{ #category : 'configuration' }
AbstractProfiler >> newMethodProxy: aMethod [ 
	^ self subclassResponsibility
]

{ #category : 'profiling' }
AbstractProfiler >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]

{ #category : 'profiling' }
AbstractProfiler >> startProfiling [

	methodProxies valuesDo: #install
]

{ #category : 'profiling' }
AbstractProfiler >> stopProfiling [

	methodProxies valuesDo: #uninstall
]
