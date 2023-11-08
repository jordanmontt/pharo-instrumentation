Class {
	#name : 'MPMethod',
	#superclass : 'S2Method',
	#instVars : [
		'executed',
		'senders'
	],
	#category : 'InstrumentationTechniques-Spy2',
	#package : 'InstrumentationTechniques',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
MPMethod >> afterRun: methodName with: listOfArguments in: receiver [
	self profiler stack pop.
]

{ #category : 'hooks' }
MPMethod >> beforeRun: methodName with: listOfArguments in: receiver [
	| caller |
	executed := true.
	caller := self profiler stack top.
	senders add: caller.
	self profiler stack push: self.
	
]

{ #category : 'hooks' }
MPMethod >> initialize [ 
	super initialize. 
	executed := false.
	senders := Set new.
]

{ #category : 'hooks' }
MPMethod >> senders [
	^ senders
]

{ #category : 'hooks' }
MPMethod >> wasExecuted [ 
	^ executed
]
