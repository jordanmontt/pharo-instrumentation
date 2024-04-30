Class {
	#name : 'AbstractMethodCoverageProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'calledMethods'
	],
	#category : 'InstrumentationProfilers-Core',
	#package : 'InstrumentationProfilers',
	#tag : 'Core'
}

{ #category : 'profiling' }
AbstractMethodCoverageProfiler >> callingMethod: aMethod [

	calledMethods add: aMethod
]

{ #category : 'initialization' }
AbstractMethodCoverageProfiler >> initialize [

	super initialize.
	calledMethods := Set new
]
