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

	afterAction := aBlockClosure "We want the squares [] "
]

{ #category : 'accessing' }
SourceCodeModificatorProfiler >> beforeAction: aBlockClosure [
	"The before action can receive the method that is being instrumented as an argument.
	Optional"

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

	| beforeActionString afterActionString pragmasString originalCodeString instrumentedMethodCode |
	beforeActionString := self wrapWithMetaSafeMechanism:
		'[ ' , beforeAction asString , ' cull: ' , aMethod nameForProfiler , ' ]'.
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

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> profile: aBlock [

	self instrument.
	aBlock ensure: [ self uninstrument ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument [

	methodsToInstrument do: [ :originalMethod |
		self uninstrument: originalMethod ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument: aMethod [

	aMethod methodClass methodDict at: aMethod selector put: aMethod
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> wrapWithMetaSafeMechanism: aBlockAsString [

	^ '    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: ' , aBlockAsString , ' ].'
]
