"
Important:

In order to this profiler to work correctly, the methods to be instrumented need to have the pragma declaration before the temp variables.

Example:

This WORKS:

```
methodWithPragma
  <primitive: 'prim' module: 'AModule' error: error>
  | var1 var2 |
  var1 := 4.
  self doSomething: error
```

This DOES NOT work:

```
methodWithPragma
  | var1 var2 |
  <primitive: 'prim' module: 'AModule' error: error>      
  var1 := 4.
  self doSomething: error
```
"
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

	afterAction := aBlockClosure
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
SourceCodeModificatorProfiler >> wrapBeforeActionFor: aMethod [

	^ self wrapWithMetaSafeMechanism:
		  '[ ' , beforeAction asString , ' cull: ' , aMethod nameForProfiler , ' ]'
]

{ #category : 'profiling' }
SourceCodeModificatorProfiler >> wrapWithMetaSafeMechanism: aBlockAsString [

	^ '    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: ' , aBlockAsString , ' ].'
]
