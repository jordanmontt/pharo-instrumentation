Class {
	#name : #RWIMockMethodProxyHandler,
	#superclass : #RWIHandler,
	#category : #'MethodProxiesRunWithIn-Tests' 
}

{ #category : #evaluating }
RWIMockMethodProxyHandler >> afterExecutionWithReceiver: receiver arguments: arguments returnValue: returnValue [

	^ 'trapped [', returnValue asString, ']'
]
