Class {
	#name : 'PrfRWIMethodIntercepter',
	#superclass : 'AbstractPrfMethodIntercepter',
	#category : 'MethodProfiler-runWitnIn',
	#package : 'MethodProfiler',
	#tag : 'runWitnIn'
}

{ #category : 'accessing' }
PrfRWIMethodIntercepter >> methodProxyClass [

	^ MpRWIMethodProxy
]
