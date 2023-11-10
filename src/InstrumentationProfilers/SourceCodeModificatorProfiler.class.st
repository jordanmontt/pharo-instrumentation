Class {
	#name : 'SourceCodeModificatorProfiler',
	#superclass : 'Object',
	#instVars : [
		'methodsToInstrument',
		'hiddenSelector'
	],
	#category : 'InstrumentationProfilers',
	#package : 'InstrumentationProfilers'
}

{ #category : 'adding' }
SourceCodeModificatorProfiler >> addMethods: methodsCollection [

	methodsToInstrument addAll: methodsCollection
]

{ #category : 'evaluating' }
SourceCodeModificatorProfiler >> afterMethod [

	5 + 5 > 7
		ifTrue: [
			OrderedCollection new
				add: 4;
				yourself ]
		ifFalse: [ self ].
	self
]

{ #category : 'evaluating' }
SourceCodeModificatorProfiler >> beforeMethod [

	5 + 5 > 7
		ifTrue: [
			OrderedCollection new
				add: 4;
				yourself ]
		ifFalse: [ self ].
	self
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
	beforeMethodBody := (self class >> #beforeMethod) ast body sourceCode.
	afterMethodBody := (self class >> #afterMethod) ast body sourceCode.

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
SourceCodeModificatorProfiler >> startProfiling [
]

{ #category : 'adding' }
SourceCodeModificatorProfiler >> stopProfiling [
]
