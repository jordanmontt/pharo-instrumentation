Class {
	#name : 'Spy2CallGraphMethod',
	#superclass : 'S2Method',
	#instVars : [
		'senders',
		'wasExecuted'
	],
	#category : 'InstrumentationTechniques-Spy2',
	#package : 'InstrumentationTechniques',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
Spy2CallGraphMethod >> afterRun: methodName with: listOfArguments in: receiver [

	self profiler stack pop
]

{ #category : 'hooks' }
Spy2CallGraphMethod >> beforeRun: methodName with: listOfArguments in: receiver [

	| caller |
	wasExecuted := true.
	caller := self profiler stack top.
	senders add: caller.
	self profiler stack push: self
]

{ #category : 'initialization' }
Spy2CallGraphMethod >> initialize [

	super initialize.
	wasExecuted := false.
	senders := Set new
]

{ #category : 'hooks' }
Spy2CallGraphMethod >> senders [

	^ senders
]

{ #category : 'hooks' }
Spy2CallGraphMethod >> wasExecuted [

	^ wasExecuted
]
