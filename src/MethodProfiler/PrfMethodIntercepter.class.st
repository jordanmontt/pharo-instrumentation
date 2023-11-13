Class {
	#name : 'PrfMethodIntercepter',
	#superclass : 'AbstractPrfMethodIntercepter',
	#category : 'MethodProfiler-MethodProxies',
	#package : 'MethodProfiler',
	#tag : 'MethodProxies'
}

{ #category : 'accessing' }
PrfMethodIntercepter >> methodProxyClass [

	^ MpMethodProxy
]
