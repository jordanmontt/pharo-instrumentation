Class {
	#name : #RWITestConcurrentSharedObject,
	#superclass : #Object,
	#instVars : [
		'concurrencySemaphore'
	],
	#category : #'Tests'
}

{ #category : #accessing }
RWITestConcurrentSharedObject >> concurrencySemaphore [

	^ concurrencySemaphore
]

{ #category : #accessing }
RWITestConcurrentSharedObject >> concurrencySemaphore: anObject [

	concurrencySemaphore := anObject
]

{ #category : #initialization }
RWITestConcurrentSharedObject >> initialize [ 
	self concurrencySemaphore: (Semaphore new).
]

{ #category : #debugging }
RWITestConcurrentSharedObject >> methodProcess1 [
	"We are in instrumented territory this trigger should be registered."
	self trigger1.
	"Let the second thread end its before execution and wait for its signal."
	concurrencySemaphore signal.
	concurrencySemaphore wait.
]

{ #category : #debugging }
RWITestConcurrentSharedObject >> methodProcess2 [
	"Do nothing"
]

{ #category : #debugging }
RWITestConcurrentSharedObject >> trigger1 [
	"Proxified method being counted"
]

{ #category : #debugging }
RWITestConcurrentSharedObject >> trigger2 [
	"Proxified method being counted"
]
