"
Important, my users need to implement the methods `startProfiling` and `stopProfiling`. Also my users need to initialize the variable callStack with `callStack := CallGraphProcessCallStack onProfiler: self.` and the `nodes` variable with `nodes := Dictionary new`
"
Trait {
	#name : 'TCallGraph',
	#instVars : [
		'callStack',
		'nodes'
	],
	#category : 'InstrumentationProfilers',
	#package : 'InstrumentationProfilers'
}

{ #category : 'accessing' }
TCallGraph >> callStack [

	^ callStack
]

{ #category : 'initialization' }
TCallGraph >> enteringMethod: aMethod [

	| node callerNode |
	callStack ensureStackIsInitialized.
	callerNode := callStack top.
	node := self nodeForMethod: aMethod.
	node addCall.
	callerNode addCallTo: node.
	callStack push: node
]

{ #category : 'initialization' }
TCallGraph >> exitingMethod [

	callStack pop
]

{ #category : 'initialization' }
TCallGraph >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ CallGraphMethodNode forMethod: method ]
]

{ #category : 'accessing' }
TCallGraph >> nodes [

	^ nodes
]

{ #category : 'initialization' }
TCallGraph >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]
