"
I'm counting the number of times I'm executed. 
"
Class {
	#name : 'RWICountingHandler',
	#superclass : 'RWIHandler',
	#instVars : [
		'count'
	],
	#category : 'MethodProxiesRunWithIn-Tests',
	#package : 'MethodProxiesRunWithIn-Tests'
}

{ #category : 'evaluating' }
RWICountingHandler >> beforeExecutionWithReceiver: aReceiver arguments: args [ 

	self count: self count + 1
]

{ #category : 'accessing' }
RWICountingHandler >> count [

	^ count
]

{ #category : 'accessing' }
RWICountingHandler >> count: anInteger [

	count := anInteger
]

{ #category : 'initialization' }
RWICountingHandler >> initialize [

	super initialize.
	self count: 0.

]
