Class {
	#name : 'SourceCodeModificatorUnsafeProfilerTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler',
		'beforeActionBlock',
		'afterActionBlock'
	],
	#category : 'InstrumentationProfilers-Tests-SourceCodeModificator',
	#package : 'InstrumentationProfilers-Tests',
	#tag : 'SourceCodeModificator'
}

{ #category : 'running' }
SourceCodeModificatorUnsafeProfilerTest >> setUp [

	super setUp.

	SingletonClasToTest reset.
	profiler := SourceCodeModificatorUnsafeProfiler new.
	beforeActionBlock := [ :method | SingletonClasToTest current increment ].
	afterActionBlock := [ SingletonClasToTest current increment ]
]

{ #category : 'running' }
SourceCodeModificatorUnsafeProfilerTest >> tearDown [

	profiler uninstrument.
	super tearDown
]

{ #category : 'tests' }
SourceCodeModificatorUnsafeProfilerTest >> testInstrumentFollowsPrototypeTrap [


	| prototypeInstrumentedMethod originalSourceCode |
	originalSourceCode := (AClassToInstrument >> #prototypeTrap) sourceCode.
	prototypeInstrumentedMethod := 'prototypeTrap
#beforeAction cull: ''AClassToInstrument>>#prototypeTrap''.
    [ #originalCodeMethod ] ensure: [
    #afterAction ]'.

	profiler
		beforeAction: '#beforeAction';
		afterAction: '#afterAction';
		addMethods: { (AClassToInstrument >> #prototypeTrap) };
		instrument.

	self assert: (AClassToInstrument >> #prototypeTrap) sourceCode equals: prototypeInstrumentedMethod.

	profiler uninstrument.
	self assert: originalSourceCode equals: (AClassToInstrument >> #prototypeTrap) sourceCode
]

{ #category : 'tests' }
SourceCodeModificatorUnsafeProfilerTest >> testInstrumentFollowsPrototypeTrapWithArgs [


	| prototypeInstrumentedMethod originalSourceCode |
	originalSourceCode := (AClassToInstrument >> #prototypeTrap:arg2: ) sourceCode.
	prototypeInstrumentedMethod := 'prototypeTrap: arg1 arg2: arg2
#beforeAction cull: ''AClassToInstrument>>#prototypeTrap:arg2:''.
    [ #originalCodeMethod ] ensure: [
    #afterAction ]'.

	profiler
		beforeAction: '#beforeAction';
		afterAction: '#afterAction';
		addMethods: { (AClassToInstrument >> #prototypeTrap:arg2:) };
		instrument.

	self assert: (AClassToInstrument >> #prototypeTrap:arg2:) sourceCode equals: prototypeInstrumentedMethod.

	profiler uninstrument.
	self assert: originalSourceCode equals: (AClassToInstrument >> #prototypeTrap:arg2:) sourceCode
]
