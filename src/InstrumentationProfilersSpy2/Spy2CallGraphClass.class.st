Class {
	#name : 'Spy2CallGraphClass',
	#superclass : 'S2Class',
	#category : 'InstrumentationProfilersSpy2-Spy2',
	#package : 'InstrumentationProfilersSpy2',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
Spy2CallGraphClass class >> spyClassForMethod [
	 ^ Spy2CallGraphMethod 
]
