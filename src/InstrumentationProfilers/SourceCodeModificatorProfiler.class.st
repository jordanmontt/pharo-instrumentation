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

{ #category : 'evaluating' }
SourceCodeModificatorProfiler class >> buildPrototypesUpToArguments: maxNumberOfArguments [
	"This method builds/compiles the prototype traps for arguments up to the argument.
	The trap prototypes are installed in this class' class side.
	They can later be copied and patched by MpMethodProxy"

	"self buildPrototypesUpToArguments: 15"

	| forwarders |
	0 to: maxNumberOfArguments do: [ :numberOfArguments |
		| originalAst trapSelector trapArguments |
		originalAst := (self class >> #prototypeTrap) parseTree.

		trapSelector := #trapMethod.
		1 to: numberOfArguments do: [ :i |
		trapSelector := trapSelector , #with: ].
		trapArguments := (1 to: numberOfArguments) collect: [ :i |
			                 RBVariableNode named: 'arg' , i asString ].

		originalAst selector: trapSelector.
		originalAst arguments: trapArguments.

		forwarders := originalAst sendNodes select: [ :e |
			              e selector = #originalMessage ].
		forwarders do: [ :e |
			e replaceWith: (RBMessageNode
					 receiver: RBVariableNode selfNode
					 selector: trapSelector
					 arguments: trapArguments) ].
		self class compile: originalAst formattedCode ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler class >> prototypeTrap [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethod [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 with: arg13 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 with: arg13 with: arg14 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler class >> trapMethodwith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6 with: arg7 with: arg8 with: arg9 with: arg10 with: arg11 with: arg12 with: arg13 with: arg14 with: arg15 [

	Processor activeProcess isMeta ifFalse: [
		Processor activeProcess runInMetaLevel: [ #beforeAction cull: #originalMethod ] ].

	[ #originalCodeMethod ] ensure: [
		Processor activeProcess isMeta ifFalse: [
			Processor activeProcess runInMetaLevel: #afterAction ] ]
]

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

	| instrumentedMethodCode index |
	instrumentedMethodCode := (self prototypeTrapMethodFor: aMethod) methodNode body sourceCode.

	index := instrumentedMethodCode findString: '#beforeAction' startingAt: 0 caseSensitive: true.
	instrumentedMethodCode := instrumentedMethodCode copyReplaceFrom: index
		to: '#beforeAction' size + index - 1
		with: beforeAction asString.

	index := instrumentedMethodCode findString: '#originalMethod' startingAt: 0 caseSensitive: true.
	instrumentedMethodCode := instrumentedMethodCode copyReplaceFrom: index
		to: '#originalMethod' size + index - 1
		with: aMethod name.

	index := instrumentedMethodCode findString: '#originalCodeMethod' startingAt: 0 caseSensitive: true.
	instrumentedMethodCode := instrumentedMethodCode copyReplaceFrom: index
		to: '#originalCodeMethod' size + index - 1
		with: aMethod methodNode body sourceCode.

	index := instrumentedMethodCode findString: '#afterAction' startingAt: 0 caseSensitive: true.
	instrumentedMethodCode := instrumentedMethodCode copyReplaceFrom: index
		to: '#afterAction' size + index - 1
		with: afterAction asString.

	instrumentedMethodCode := aMethod sourceNode selectorAndArgumentNames , String cr , instrumentedMethodCode.

	aMethod methodClass compile: instrumentedMethodCode
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> oldInstrument: aMethod [

	| instrumentedSourceCode methodSignature trapMethodCode |
	methodSignature := aMethod sourceNode selectorAndArgumentNames.
	trapMethodCode := self class >> #trapMethod.

	instrumentedSourceCode := String streamContents: [ :stream | 
		stream << methodSignature << String cr <<
			(beforeAction cull: aMethod name) << '.' << String cr <<
			'[ ' << aMethod ast body sourceCode << ' ]' << String cr <<
			'ensure: ' << afterAction ].

	aMethod methodClass compile: instrumentedSourceCode
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> profile: aBlock [

	self instrument.
	aBlock ensure: [ self uninstrument ]
]

{ #category : 'as yet unclassified' }
SourceCodeModificatorProfiler >> prototypeTrapMethodFor: aMethod [

	^ self class class methods detect: [ :m |
		  m numArgs = aMethod numArgs and: [
			  m selector beginsWith: 'trap' ] ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument [

	methodsToInstrument do: [ :originalMethod |
		self uninstrument: originalMethod ]
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> uninstrument: aMethod [

	aMethod methodClass compile: aMethod sourceCode
]
