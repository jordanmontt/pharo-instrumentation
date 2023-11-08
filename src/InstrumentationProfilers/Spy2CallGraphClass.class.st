Class {
	#name : 'Spy2CallGraphClass',
	#superclass : 'S2Class',
	#category : 'InstrumentationProfilers-Spy2',
	#package : 'InstrumentationProfilers',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
Spy2CallGraphClass class >> spyClassForMethod [
	 ^ Spy2CallGraphMethod 
]
