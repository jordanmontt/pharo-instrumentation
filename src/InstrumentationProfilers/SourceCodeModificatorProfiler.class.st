Class {
	#name : 'SourceCodeModificatorProfiler',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'beforeAction',
		'afterAction'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'adding' }
SourceCodeModificatorProfiler >> addMethods: methodsCollection [

	methodsToInstrument addAll: methodsCollection
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> afterAction: aBlockClosure [

	afterAction := aBlockClosure asString "We want the squares [] "
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> beforeAction: aBlockClosure [
	"It needs to return a string"

	beforeAction := aBlockClosure
]

{ #category : 'initialization' }
SourceCodeModificatorProfiler >> initialize [

	super initialize.
	methodsToInstrument := Set new
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> instrument [

	methodsToInstrument do: [ :aMethod | self instrument: aMethod ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> instrument: aMethod [

	| instrumentedSourceCode methodSignature |
	methodSignature := aMethod sourceNode selectorAndArgumentNames.

	instrumentedSourceCode := String streamContents: [ :stream | 
		stream << methodSignature << String cr <<
			(beforeAction cull: aMethod) << '.' << String cr <<
			'[ ' << aMethod ast body sourceCode << ' ]' << String cr <<
			'ensure: ' << afterAction ].

	aMethod methodClass compile: instrumentedSourceCode
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> profile: aBlock [

	self instrument.
	aBlock ensure: [ self uninstrument ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument [

	methodsToInstrument do: [ :anInstrumentedMethod |
		self uninstrument: anInstrumentedMethod ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument: aMethod [

	aMethod methodClass methodDict at: aMethod selector put: aMethod
]
