Class {
	#name : 'SCMethodCoverage',
	#superclass : 'Object',
	#instVars : [
		'calledMethods'
	],
	#classVars : [
		'Instance'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'accessing' }
SCMethodCoverage class >> default [

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : 'class initialization' }
SCMethodCoverage class >> reset [

	Instance := self new
]

{ #category : 'profiling' }
SCMethodCoverage >> callingMethod: aMethod [

	calledMethods add: aMethod
]

{ #category : 'initialization' }
SCMethodCoverage >> initialize [

	super initialize.
	calledMethods := Set new
]
