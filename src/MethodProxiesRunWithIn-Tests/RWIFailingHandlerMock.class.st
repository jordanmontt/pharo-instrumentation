"
I'm a mock for tests that checks that the infrastructure does not collapse when a handler is failing.
"
Class {
	#name : 'RWIFailingHandlerMock',
	#superclass : 'RWIHandler',
	#category : 'MethodProxiesRunWithIn-Tests',
	#package : 'MethodProxiesRunWithIn-Tests'
}

{ #category : 'evaluating' }
RWIFailingHandlerMock >> beforeExecutionWithReceiver: aReceiver arguments: args [

	self error: 'error during instrumentation'
]
