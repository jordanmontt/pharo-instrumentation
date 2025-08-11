Class {
	#name : #RWIWaitBeforeHandler,
	#superclass : #RWIHandler,
	#category : #'MethodProxiesRunWithIn-Tests' 
}

{ #category : #evaluating }
RWIWaitBeforeHandler >> beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects [
	"We are inside the before, not being instrumented, wait for second thread to enter inside before."
	anObject concurrencySemaphore wait
]
