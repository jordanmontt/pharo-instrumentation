Class {
	#name : 'PrfRWIMethodIntercepter',
	#superclass : 'AbstractPrfMethodIntercepter',
	#classTraits : 'AnObsoleteTPrfMethodIntercepter classTrait',
	#category : 'MethodProfiler-runWitnIn',
	#package : 'MethodProfiler',
	#tag : 'runWitnIn'
}

{ #category : 'accessing' }
PrfRWIMethodIntercepter >> methodProxyClass [

	^ MpRWIMethodProxy
]
