Class {
	#name : 'CallGraphProcessCallStack',
	#superclass : 'ProcessLocalVariable',
	#instVars : [
		'stacks',
		'profiler'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
CallGraphProcessCallStack class >> onProfiler: aProfiler [

	^ self new
		profiler: aProfiler;
		yourself
]

{ #category : 'initialization' }
CallGraphProcessCallStack >> ensureStackIsInitialized [
	"A new thread requires a stack.
	Initialize it and store it.
	Otherwise, the process specific variable is stored in a weak array"

	| theStack |
	self value ifNotNil: [ ^ self ].
	theStack := Stack new.
	theStack push: profiler rootNode.
	stacks add: theStack.
	self value: theStack
]

{ #category : 'initialization' }
CallGraphProcessCallStack >> initialize [

	super initialize.
	stacks := IdentitySet new
]

{ #category : 'removing' }
CallGraphProcessCallStack >> pop [

	^ self value pop
]

{ #category : 'accessing' }
CallGraphProcessCallStack >> profiler: aProfiler [

	profiler := aProfiler
]

{ #category : 'adding' }
CallGraphProcessCallStack >> push: aNode [

	self ensureStackIsInitialized.
	^ self value push: aNode
]

{ #category : 'accessing' }
CallGraphProcessCallStack >> size [

	^ self value size
]

{ #category : 'accessing' }
CallGraphProcessCallStack >> top [

	^ self value top
]
