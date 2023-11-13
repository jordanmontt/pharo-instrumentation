Trait {
	#name : 'TPrfMethodNode',
	#instVars : [
		'method'
	],
	#category : 'MethodProfiler-Core',
	#package : 'MethodProfiler',
	#tag : 'Core'
}

{ #category : 'accessing' }
TPrfMethodNode >> method: anObject [

	method := anObject
]

{ #category : 'converting' }
TPrfMethodNode >> printString [
	^method printString
]
