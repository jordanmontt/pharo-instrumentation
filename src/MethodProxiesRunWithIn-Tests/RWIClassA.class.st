"
Instance Variables:
	x	<Integer>
"
Class {
	#name : #RWIClassA,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'MethodProxiesRunWithIn-Tests' 
}

{ #category : #accessing }
RWIClassA >> methodAcceptingABlock: aBlock [

	^ aBlock value
]

{ #category : #debugging }
RWIClassA >> methodDelay [

	(Delay forMilliseconds: 1) wait.
]

{ #category : #debugging }
RWIClassA >> methodLastingOneSecond [

	(Delay forMilliseconds: 0.5) wait.
	^ 999
]

{ #category : #debugging }
RWIClassA >> methodOne [
	^ 101
	
]

{ #category : #debugging }
RWIClassA >> methodTwo [
	^ 42
]

{ #category : #debugging }
RWIClassA >> methodWithArgument: anInteger [

	self x: self x + anInteger.
	^ self x
]

{ #category : #debugging }
RWIClassA >> methodWithException [

	1/0
]

{ #category : #accessing }
RWIClassA >> methodWithNonLocalReturn [

	self methodAcceptingABlock: [ ^ self ]
]

{ #category : #debugging }
RWIClassA >> methodWithWarning [

	Warning new signal: 'I warned you'.
]

{ #category : #accessing }
RWIClassA >> x [

	^ x
]

{ #category : #accessing }
RWIClassA >> x: anInteger [

	x := anInteger
]
