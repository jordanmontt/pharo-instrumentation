"
I'm a mock for tests that checks that the infrastructure does not collapse when a handler is failing.
"
Class {
	#name : #RWIFailingHandlerMock,
	#superclass : #RWIHandler,
	#category : #'MethodProxiesRunWithIn-Tests'
}

{ #category : #evaluating }
RWIFailingHandlerMock >> beforeMethod [

	self error: 'error during instrumentation'
]
