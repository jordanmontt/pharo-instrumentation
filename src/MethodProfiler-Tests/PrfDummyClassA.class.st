Class {
	#name : 'PrfDummyClassA',
	#superclass : 'Object',
	#category : 'MethodProfiler-Tests',
	#package : 'MethodProfiler-Tests'
}

{ #category : 'accessing' }
PrfDummyClassA >> bar: isExecutingFoo [
	isExecutingFoo ifTrue: [ self foo ].
	
]

{ #category : 'accessing' }
PrfDummyClassA >> foo [
]
