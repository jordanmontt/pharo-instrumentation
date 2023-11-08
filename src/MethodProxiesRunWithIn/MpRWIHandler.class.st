"
I'm the root of hierarchy of objects that can perform computation in place of method such as counting execution...
The main API is composed of two methods: 
- `afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: aReturnValue`
- `beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects`
"
Class {
	#name : 'MpRWIHandler',
	#superclass : 'Object',
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'evaluating' }
MpRWIHandler >> aboutToReturnWithReceiver: receiver arguments: arguments [

	self afterMethod
]

{ #category : 'evaluating' }
MpRWIHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: aReturnValue [

	^ aReturnValue
]

{ #category : 'evaluating' }
MpRWIHandler >> afterMethod [
	"Perform action after execution."
]

{ #category : 'evaluating' }
MpRWIHandler >> beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects [

	self beforeMethod
]

{ #category : 'evaluating' }
MpRWIHandler >> beforeMethod [
]

{ #category : 'evaluating' }
MpRWIHandler >> captureCallingContext [

	| runWithInContext |
	
	"Find the context of #run:with:in:"	
	runWithInContext := thisContext sender.
	[ runWithInContext isNil 
		or: [ runWithInContext method isCompiledMethod and: [runWithInContext method selector = #run:with:in:] ] ] 
		whileFalse: [ runWithInContext := runWithInContext sender ].
	
	"Find the real sender"	
	^ runWithInContext ifNotNil: [ runWithInContext sender ]
]
