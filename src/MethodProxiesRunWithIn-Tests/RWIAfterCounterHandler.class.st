"
I am a method proxy handler for testing that increments a counter after the method has been executed.
I therefore test method exit
"
Class {
	#name : 'RWIAfterCounterHandler',
	#superclass : 'RWIHandler',
	#instVars : [
		'count'
	],
	#category : 'MethodProxiesRunWithIn-Tests',
	#package : 'MethodProxiesRunWithIn-Tests'
}

{ #category : 'evaluating' }
RWIAfterCounterHandler >> afterExecutionWithReceiver: aReceiver arguments: args returnValue: returnValue [

	count := count + 1.
	^ returnValue
]

{ #category : 'accessing' }
RWIAfterCounterHandler >> count [
	^ count
]

{ #category : 'evaluating' }
RWIAfterCounterHandler >> initialize [

	super initialize.
	count := 0
]
