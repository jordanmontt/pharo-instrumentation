Class {
	#name : 'AClassToInstrument',
	#superclass : 'Object',
	#category : 'InstrumentationProfilers-Tests',
	#package : 'InstrumentationProfilers-Tests'
}

{ #category : 'accessing' }
AClassToInstrument >> foo [

	SingletonClasToTest current increment
]

{ #category : 'accessing' }
AClassToInstrument >> fooWithException [

	Error signal.
	SingletonClasToTest current increment
]
