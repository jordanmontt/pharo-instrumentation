"
I'm the root of hierarchy of objects that can perform computation in place of method such as counting execution...
The main API is composed of two methods: 
- `afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: aReturnValue`
- `beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects`
"
Class {
	#name : 'RWIHandler',
	#superclass : 'Object',
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'evaluating' }
RWIHandler >> aboutToReturnWithReceiver: receiver arguments: arguments [

	self afterMethod
]

{ #category : 'evaluating' }
RWIHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: aReturnValue [

	^ aReturnValue
]

{ #category : 'evaluating' }
RWIHandler >> afterMethod [
	"Perform action after execution."
]

{ #category : 'evaluating' }
RWIHandler >> beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects [

	self beforeMethod
]

{ #category : 'evaluating' }
RWIHandler >> beforeMethod [
]

{ #category : 'evaluating' }
RWIHandler >> captureCallingContext [

	| runWithInContext |
	
	"Find the context of #run:with:in:"	
	runWithInContext := thisContext sender.
	[ runWithInContext isNil 
		or: [ runWithInContext method isCompiledMethod and: [runWithInContext method selector = #run:with:in:] ] ] 
		whileFalse: [ runWithInContext := runWithInContext sender ].
	
	"Find the real sender"	
	^ runWithInContext ifNotNil: [ runWithInContext sender ]
]
