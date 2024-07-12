Class {
	#name : 'SourceCodeInstrumentator',
	#superclass : 'Object',
	#instVars : [
		'afterAction',
		'methodsToInstrument',
		'beforeAction'
	],
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'accessing' }
SourceCodeInstrumentator >> afterAction: aBlockClosure [

	afterAction := aBlockClosure
]

{ #category : 'accessing' }
SourceCodeInstrumentator >> beforeAction: aBlockClosure [
	"The before action can receive the method that is being instrumented as an argument.
	Optional"

	beforeAction := aBlockClosure
]

{ #category : 'initialization' }
SourceCodeInstrumentator >> initialize [

	super initialize.
	methodsToInstrument := Set new
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> instrument [

	methodsToInstrument do: [ :aMethod | self instrument: aMethod ].
	self reset
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> instrument: aMethod [

	| beforeActionString afterActionString pragmasString originalCodeString instrumentedMethodCode |
	beforeActionString := self wrapBeforeActionFor: aMethod.
	afterActionString := self wrapWithMetaSafeMechanism: afterAction asString.
	originalCodeString := '[ ' , aMethod methodNode body sourceCode , ' ]'.
	pragmasString := aMethod pragmas inject: '' into: [ :sum :node | sum , node asString , String cr].

	instrumentedMethodCode := String streamContents: [ :stream |
		stream << pragmasString <<
			beforeActionString << String cr
			<< '    ' << originalCodeString << ' ensure: [' << String cr <<
			'    ' << afterActionString << ' ]' ].
	
	instrumentedMethodCode := aMethod sourceNode selectorAndArgumentNames , String cr , instrumentedMethodCode.
	
	aMethod methodClass compile: instrumentedMethodCode
]

{ #category : 'accessing' }
SourceCodeInstrumentator >> methods: methodsCollection [

	methodsToInstrument addAll: methodsCollection
]

{ #category : 'as yet unclassified' }
SourceCodeInstrumentator >> reset [

	
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> uninstrument [

	methodsToInstrument do: [ :originalMethod |
		self uninstrument: originalMethod ]
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> uninstrument: aMethod [

	aMethod methodClass methodDict at: aMethod selector put: aMethod
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> wrapBeforeActionFor: aMethod [

	^ self wrapWithMetaSafeMechanism:
		  '[ ' , beforeAction asString , ' cull: ' , aMethod nameForProfiler , ' ]'
]

{ #category : 'profiling' }
SourceCodeInstrumentator >> wrapWithMetaSafeMechanism: aBlockAsString [

	^ '    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: ' , aBlockAsString , ' ].'
]
