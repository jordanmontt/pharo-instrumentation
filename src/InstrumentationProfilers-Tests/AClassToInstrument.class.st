Class {
	#name : 'AClassToInstrument',
	#superclass : 'Object',
	#category : 'InstrumentationProfilers-Tests-SourceCodeModificator',
	#package : 'InstrumentationProfilers-Tests',
	#tag : 'SourceCodeModificator'
}

{ #category : 'accessing' }
AClassToInstrument >> bar [

	SingletonClasToTest current increment
]

{ #category : 'accessing' }
AClassToInstrument >> foo [

	SingletonClasToTest current increment
]

{ #category : 'accessing' }
AClassToInstrument >> fooWithException [

	Error signal.
	SingletonClasToTest current increment
]

{ #category : 'accessing' }
AClassToInstrument >> poo [

	SingletonClasToTest current increment
]

{ #category : 'accessing' }
AClassToInstrument >> tempy [

	| var1 var2 var3 |
	var1 := SingletonClasToTest current increment.
	var2 := nil.
	var3 := 0
]
