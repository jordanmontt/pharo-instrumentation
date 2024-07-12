Class {
	#name : 'MethodCoverageProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'calledMethods'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'profiling' }
MethodCoverageProfiler >> callingMethod: aMethod [

	calledMethods add: aMethod
]

{ #category : 'initialization' }
MethodCoverageProfiler >> initialize [

	super initialize.
	calledMethods := Set new
]
