Class {
	#name : 'StackMethodNode',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sender'
	],
	#category : 'InstrumentationProfilersMetaLink',
	#package : 'InstrumentationProfilersMetaLink'
}

{ #category : 'accessing' }
StackMethodNode >> name: aName [

	name := aName
]

{ #category : 'initialization' }
StackMethodNode >> sender: aNode [

	sender := aNode
]
