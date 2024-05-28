Class {
	#name : 'MpCallGraphProfiler',
	#superclass : 'AbstractCallGraphProfiler',
	#category : 'InstrumentationProfilers-Trap-Method',
	#package : 'InstrumentationProfilers',
	#tag : 'Trap-Method'
}

{ #category : 'configuration' }
MpCallGraphProfiler >> newHandler: aMethod [

	^ MpCallGraphHandler onMethod: aMethod nameForProfiler profiler: self
]

{ #category : 'configuration' }
MpCallGraphProfiler >> newMethodProxy: aMethod [

	^ MpMethodProxy onMethod: aMethod handler: (self newHandler: aMethod)
]
