Class {
	#name : 'StackMethodNode',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sender'
	],
	#category : 'InstrumentationProfilers-MetaLink',
	#package : 'InstrumentationProfilers',
	#tag : 'MetaLink'
}

{ #category : 'accessing' }
StackMethodNode >> name: aName [

	name := aName
]

{ #category : 'initialization' }
StackMethodNode >> sender: aNode [

	sender := aNode
]
