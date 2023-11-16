Class {
	#name : 'AbstractCallGraphProfiler',
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

{ #category : 'api' }
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

{ #category : 'accessing' }
AbstractCallGraphProfiler >> callStack [

	^ callStack
]

{ #category : 'api' }
AbstractCallGraphProfiler >> enteringMethod: aMethod [

	| node callerNode |
	callStack ensureStackIsInitialized.
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node.
	"profiler callStack ensureStackIsInitialized.
	callerNode := profiler callStack top.
	node := profiler nodeForMethod: method.
	callerNode addCallTo: node.
	node addCall.
	profiler callStack push: node"
]

{ #category : 'api' }
AbstractCallGraphProfiler >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
AbstractCallGraphProfiler >> initialize [

	super initialize.
	methodProxies := Dictionary new.
	nodes := Dictionary new.
	callStack := CallGraphProcessCallStack onProfiler: self
]

{ #category : 'instrumentation' }
AbstractCallGraphProfiler >> installMethodProxies [

	methodProxies valuesDo: #install
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
AbstractCallGraphProfiler >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
AbstractCallGraphProfiler >> nodes [

	^ nodes
]

{ #category : 'api' }
AbstractCallGraphProfiler >> profile: aBlock [

	self startProfiling.
	[ aBlock value ] ensure: [ self stopProfiling ]
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

	self installMethodProxies
]

{ #category : 'profiling' }
AbstractCallGraphProfiler >> stopProfiling [

	self uninstallMethodProxies
]

{ #category : 'instrumentation' }
AbstractCallGraphProfiler >> uninstallMethodProxies [

	methodProxies valuesDo: #uninstall
]