Class {
	#name : 'RWICalledHandler',
	#superclass : 'RWIHandler',
	#instVars : [
		'called'
	],
	#category : 'MethodProxiesRunWithIn-Tests',
	#package : 'MethodProxiesRunWithIn-Tests'
}

{ #category : 'evaluating' }
RWICalledHandler >> beforeExecutionWithReceiver: aReceiver arguments: args [

	called := true
]

{ #category : 'evaluating' }
RWICalledHandler >> called [

	^ called
]

{ #category : 'evaluating' }
RWICalledHandler >> called: aBoolean [

	called := aBoolean
]

{ #category : 'initialization' }
RWICalledHandler >> initialize [

	super initialize.
	called := false
]
