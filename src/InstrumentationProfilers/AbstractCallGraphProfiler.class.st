Class {
	#name : 'AbstractCallGraphProfiler',
	#superclass : 'Object',
	#traits : 'TCallGraph',
	#classTraits : 'TCallGraph classTrait',
	#instVars : [
		'methodProxies'
	],
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'private' }
AbstractCallGraphProfiler >> addMethod: aMethod [

	methodProxies
		at: aMethod
		put: (self newMethodProxy: aMethod)
]

{ #category : 'api' }
AbstractCallGraphProfiler >> addMethods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method | self addMethod: method ]
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> initialize [

	super initialize.
	methodProxies := Dictionary new.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'accessing' }
AbstractCallGraphProfiler >> methodProxies [

	^ methodProxies
]

{ #category : 'configuration' }
AbstractCallGraphProfiler >> newHandler: aMethod [ 
	^ self subclassResponsibility
]

{ #category : 'configuration' }
AbstractCallGraphProfiler >> newMethodProxy: aMethod [ 
	^ self subclassResponsibility
]

{ #category : 'configuration' }
AbstractCallGraphProfiler >> rootNode [

	| rootNode |
	rootNode := CallGraphMethodNode forMethod: #root.
	nodes at: #root put: rootNode.
	^ rootNode
]

{ #category : 'profiling' }
AbstractCallGraphProfiler >> startProfiling [

	methodProxies valuesDo: #install
]

{ #category : 'profiling' }
AbstractCallGraphProfiler >> stopProfiling [

	methodProxies valuesDo: #uninstall
]
