Class {
	#name : #RWIMockMethodProxyHandler,
	#superclass : #RWIHandler,
	#category : #'Tests'
}

{ #category : #evaluating }
RWIMockMethodProxyHandler >> afterExecutionWithReceiver: receiver arguments: arguments returnValue: returnValue [

	^ 'trapped [', returnValue asString, ']'
]
