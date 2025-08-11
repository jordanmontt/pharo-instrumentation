"
I am a method proxy handler for testing that increments a counter after the method has been executed.
I therefore test method exit
"
Class {
	#name : #RWIAfterCounterHandler,
	#superclass : #RWIHandler,
	#instVars : [
		'count'
	],
	#category : #'MethodProxiesRunWithIn-Tests' 
}

{ #category : #evaluating }
RWIAfterCounterHandler >> afterMethod [

	count := count + 1
]

{ #category : #accessing }
RWIAfterCounterHandler >> count [
	^ count
]

{ #category : #evaluating }
RWIAfterCounterHandler >> initialize [

	super initialize.
	count := 0
]
