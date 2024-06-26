Class {
	#name : 'PrfTreeMethodNode',
	#superclass : 'PrfLiveNode',
	#traits : 'TPrfMethodNode',
	#classTraits : 'TPrfMethodNode classTrait',
	#category : 'MethodProfiler-Core',
	#package : 'MethodProfiler',
	#tag : 'Core'
}

{ #category : 'creation' }
PrfTreeMethodNode class >> forMethod: aMethod withResult: aResultObject withHash: aString [

	| node |
	node := self new.
	node method: aMethod.
	node result: aResultObject.
	node nodeHash: aString.
	^ node
]
