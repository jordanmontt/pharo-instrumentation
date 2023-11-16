Class {
	#name : 'CallGraphMethodNode',
	#superclass : 'Object',
	#instVars : [
		'methodCalls',
		'timesCalled',
		'method'
	],
	#category : 'InstrumentationProfilers-CallGraph',
	#package : 'InstrumentationProfilers',
	#tag : 'CallGraph'
}

{ #category : 'as yet unclassified' }
CallGraphMethodNode class >> forMethod: aMethod [

	^ self new
		method: aMethod;
		yourself
]

{ #category : 'initialization' }
CallGraphMethodNode >> addCall [

	timesCalled := timesCalled + 1
]

{ #category : 'initialization' }
CallGraphMethodNode >> addCallTo: aNode [

	methodCalls add: aNode
]

{ #category : 'initialization' }
CallGraphMethodNode >> initialize [

	super initialize.
	methodCalls := Bag new.
	timesCalled := 0
]

{ #category : 'accessing' }
CallGraphMethodNode >> method [
	^ method
]

{ #category : 'accessing' }
CallGraphMethodNode >> method: aMethod [

	method := aMethod
]

{ #category : 'accessing' }
CallGraphMethodNode >> methodCalls [
	^ methodCalls
]

{ #category : 'printing' }
CallGraphMethodNode >> printOn: aStream [

	aStream << 'Node on: '.
	method printOn: aStream
]

{ #category : 'accessing' }
CallGraphMethodNode >> timesCalled [
	^ timesCalled
]
