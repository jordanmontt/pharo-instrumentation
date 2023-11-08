Class {
	#name : 'MethodProfiler',
	#superclass : 'S2Profiler',
	#instVars : [
		'callStack'
	],
	#category : 'InstrumentationTechniques-Spy2',
	#package : 'InstrumentationTechniques',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
MethodProfiler class >> spyClassForPackage [
	^ MPPackage
]

{ #category : 'hooks' }
MethodProfiler >> initialize [ 
	super initialize.
	callStack := Stack new.
	callStack push: (MPMethod new selector:#root;yourself).
]

{ #category : 'hooks' }
MethodProfiler >> registryName [
	^ #MethodProfiler
]

{ #category : 'hooks' }
MethodProfiler >> stack [
 	^ callStack
]
