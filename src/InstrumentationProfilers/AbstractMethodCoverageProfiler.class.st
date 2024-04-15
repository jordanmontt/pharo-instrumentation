Class {
	#name : 'AbstractMethodCoverageProfiler',
	#superclass : 'AbstractProfiler',
	#instVars : [
		'calledMethods'
	],
	#category : 'InstrumentationProfilers-Method-Coverage',
	#package : 'InstrumentationProfilers',
	#tag : 'Method-Coverage'
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
