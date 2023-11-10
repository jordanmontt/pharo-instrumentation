Class {
	#name : 'SourceCodeModificatorProfiler',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'hiddenSelector',
		'beforeAction',
		'afterAction'
	],
	#category : 'InstrumentationProfilers',
	#package : 'InstrumentationProfilers'
}

{ #category : 'adding' }
SourceCodeModificatorProfiler >> addMethods: methodsCollection [

	methodsToInstrument addAll: methodsCollection
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> afterAction: aFullBlockClosure [

	afterAction := aFullBlockClosure
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> beforeAction: aFullBlockClosure [

	beforeAction := aFullBlockClosure
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> hiddenSelector [

	^ hiddenSelector
]

{ #category : 'initialization' }
SourceCodeModificatorProfiler >> initialize [

	super initialize.
	methodsToInstrument := Set new.
	hiddenSelector := MpHiddenSelector new
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> instrument [

	methodsToInstrument do: [ :aMethod | self instrument: aMethod ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> instrument: aMethod [

	| beforeMethodBody afterMethodBody instrumentedSourceCode methodSignature |
	methodSignature := aMethod sourceNode selectorAndArgumentNames.
	beforeMethodBody := beforeAction method ast body sourceCode.
	afterMethodBody := afterAction method ast body sourceCode.

	instrumentedSourceCode := String streamContents: [ :stream | 
		stream << methodSignature << String cr <<
			beforeMethodBody << '.' << String cr <<
			'[ ' << aMethod ast body sourceCode << ' ]' << String cr <<
			' ensure: [ ' << afterMethodBody << ' ]' ].

	"Keep the original method to restore it later"	
	aMethod methodClass methodDict
		at: hiddenSelector
		put: aMethod.

	aMethod methodClass compile: instrumentedSourceCode
]

{ #category : 'adding' }
SourceCodeModificatorProfiler >> profile: aBlock [

	self instrument.
	aBlock ensure: [ self uninstrument ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> uninstrument [

	methodsToInstrument do: [ :anInstrumentedMethod |
		self uninstrument: anInstrumentedMethod ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> uninstrument: aMethod [

	| originalMethod |
	originalMethod := aMethod methodClass methodDict at: hiddenSelector.
	aMethod methodClass methodDict
		at: aMethod selector
		put: originalMethod.
	aMethod methodClass methodDict removeKey: hiddenSelector
]
