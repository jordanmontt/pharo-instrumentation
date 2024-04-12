Class {
	#name : 'AbstractMethodCoverageProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'nodes'
	],
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'profiling' }
AbstractMethodCoverageProfiler >> callingMethod: aMethod [

	(self nodeForMethod: aMethod) registerMethodCall.
]

{ #category : 'profiling' }
AbstractMethodCoverageProfiler >> nodeForMethod: method [

	^ nodes at: method
		ifPresent: [ :node | node ]
		ifAbsentPut: [ MethodCoverageNode forMethod: method ]
]
