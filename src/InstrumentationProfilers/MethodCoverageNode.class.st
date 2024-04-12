Class {
	#name : 'MethodCoverageNode',
	#superclass : 'Object',
	#instVars : [
		'method',
		'called',
		'timesCalled'
	],
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
}

{ #category : 'instance creation' }
MethodCoverageNode class >> forMethod: aMethod [

	^ self new
		  method: aMethod;
		  yourself
]

{ #category : 'initialization' }
MethodCoverageNode >> initialize [

	super initialize.
	called := false.
	timesCalled := 0
]

{ #category : 'accessing' }
MethodCoverageNode >> method: aMethod [

	method := aMethod
]

{ #category : 'api' }
MethodCoverageNode >> registerMethodCall [

	called := true.
	timesCalled := timesCalled + 1
]
