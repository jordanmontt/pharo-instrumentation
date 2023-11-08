Class {
	#name : 'Spy2CallGraphClass',
	#superclass : 'S2Class',
	#category : 'InstrumentationTechniques-Spy2',
	#package : 'InstrumentationTechniques',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
Spy2CallGraphClass class >> spyClassForMethod [
	 ^ Spy2CallGraphMethod 
]
