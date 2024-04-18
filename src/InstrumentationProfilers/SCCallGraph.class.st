Class {
	#name : 'SCCallGraph',
	#superclass : 'Object',
	#traits : 'TCallGraphBuilder',
	#classTraits : 'TCallGraphBuilder classTrait',
	#classVars : [
		'Instance'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'accessing' }
SCCallGraph class >> default [

	^ Instance ifNil: [ Instance := self new ]
]

{ #category : 'class initialization' }
SCCallGraph class >> reset [

	Instance := self new
]
