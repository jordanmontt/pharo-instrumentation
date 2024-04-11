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

	afterAction := aBlockClosure asString , ' on: Exception do: []'
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> beforeAction: aBlockClosure [

	beforeAction := aBlockClosure asString , ' on: Exception do: []'
]

{ #category : 'initialization' }
SourceCodeModificatorProfiler >> initialize [

	super initialize.
	methodsToInstrument := Set new
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> instrument [

	methodsToInstrument do: [ :aMethod | self instrument: aMethod ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> instrument: aMethod [

	| instrumentedSourceCode methodSignature |
	methodSignature := aMethod sourceNode selectorAndArgumentNames.

	instrumentedSourceCode := String streamContents: [ :stream | 
		stream << methodSignature << String cr <<
			beforeAction << '.' << String cr <<
			'[ ' << aMethod ast body sourceCode << ' ]' << String cr <<
			' ensure: [ ' << afterAction << ' ]' ].

	aMethod methodClass compile: instrumentedSourceCode
]

{ #category : 'adding' }
SourceCodeModificatorProfiler >> profile: aBlock [

	self instrument.
	[ aBlock on: Exception do: [  ] ] ensure: [ self uninstrument ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> uninstrument [

	methodsToInstrument do: [ :anInstrumentedMethod |
		self uninstrument: anInstrumentedMethod ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> uninstrument: aMethod [

	aMethod methodClass methodDict at: aMethod selector put: aMethod
]
