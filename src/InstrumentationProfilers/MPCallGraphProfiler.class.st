Class {
	#name : 'MPCallGraphProfiler',
	#superclass : 'Object',
	#instVars : [
		'methodProxies',
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'initialization' }
MPCallGraphProfiler >> addMethod: aMethod [

	methodProxies
		at: aMethod
		put: (self newMethodProxy: aMethod)
]

{ #category : 'initialization' }
MPCallGraphProfiler >> addMethods: aSetOfMethods [

	(aSetOfMethods collect: [ :method | method unproxifiedMethod ])
		do: [ :method | self addMethod: method ]

]

{ #category : 'accessing' }
MPCallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'initialization' }
MPCallGraphProfiler >> initialize [

	super initialize.
	methodProxies := Dictionary new.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'adding' }
MPCallGraphProfiler >> installMethodProxies [

	methodProxies valuesDo: #install
]

{ #category : 'initialization' }
MPCallGraphProfiler >> newHandler: aMethod [

	^ MPCallGraphHandler onMethod: aMethod profiler: self
]

{ #category : 'initialization' }
MPCallGraphProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]

{ #category : 'as yet unclassified' }
MPCallGraphProfiler >> nodeForMethod: method [

	'hola' traceCr.
	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'adding' }
MPCallGraphProfiler >> profile: aBlock [

	self startProfiling.
	[ aBlock value ] ensure: [ self stopProfiling ]
]

{ #category : 'counting' }
MPCallGraphProfiler >> rootNode [

	| rootNode |
	rootNode := CallGraphMethodNode forMethod: #root.
	nodes at: #root put: rootNode.
	^ rootNode
]

{ #category : 'adding' }
MPCallGraphProfiler >> startProfiling [

	self installMethodProxies
]

{ #category : 'adding' }
MPCallGraphProfiler >> stopProfiling [

	self uninstallMethodProxies
]

{ #category : 'adding' }
MPCallGraphProfiler >> uninstallMethodProxies [

	methodProxies valuesDo: #uninstall
]
