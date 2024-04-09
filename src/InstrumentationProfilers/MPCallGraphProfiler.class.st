Class {
	#name : 'MpCallGraphProfiler',
	#superclass : 'AbstractCallGraphProfiler',
	#category : 'InstrumentationProfilers-MethodProxies',
	#package : 'InstrumentationProfilers',
	#tag : 'MethodProxies'
}

{ #category : 'configuration' }
MpCallGraphProfiler >> newHandler: aMethod [

	^ MpCallGraphHandler onMethod: aMethod profiler: self
]

{ #category : 'configuration' }
MpCallGraphProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
