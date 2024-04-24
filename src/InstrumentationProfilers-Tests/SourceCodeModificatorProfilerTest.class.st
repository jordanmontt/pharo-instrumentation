"
A SourceCodeModificatorProfilerTest is a test class for testing the behavior of SourceCodeModificatorProfiler
"
Class {
	#name : 'SourceCodeModificatorProfilerTest',
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
SourceCodeModificatorProfilerTest >> setUp [

	super setUp.

	SingletonClasToTest reset.
	profiler := SourceCodeModificatorProfiler new.
	beforeActionBlock := [ :method | SingletonClasToTest current increment ].
	afterActionBlock := [ SingletonClasToTest current increment ]
]

{ #category : 'running' }
SourceCodeModificatorProfilerTest >> tearDown [

	profiler uninstrument.
	super tearDown
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testAfterHasLocalReturn [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: [ SingletonClasToTest current increment. ^ 5 ];
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testAfterRaisesError [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	"After should raise an error. Just like method proxies"
	profiler
		beforeAction: beforeActionBlock;
		afterAction: [ SingletonClasToTest current increment. Error signal ];
		addMethods: { (AClassToInstrument >> #foo) }.
	
	self should: [ profiler profile: profileBlock ] raise: Error.
	"foo calls one increment. Error was raised after the execution so we should have 3"
	self assert: SingletonClasToTest current counter equals: 3
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testBeforeRaisesError [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [ :method | Error signal ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) }.

	self should: [profiler profile: profileBlock ] raise: Error.
	"before raised an error so nothing else got executed"
	self assert: SingletonClasToTest current counter equals: 0
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testInstrument [

	| profileBlock originalSourceCode |
	profileBlock := [ AClassToInstrument new foo ].
	originalSourceCode := (AClassToInstrument >> #foo) sourceCode copy.

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #foo) };
		instrument.

	profileBlock value.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3.

	profiler uninstrument.
	SingletonClasToTest reset.
	profileBlock value.
	"original method restored"
	self assert: originalSourceCode equals: (AClassToInstrument >> #foo) sourceCode.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 1
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testInstrumentFollowsPrototypeTrap [


	| prototypeInstrumentedMethod originalSourceCode |
	originalSourceCode := (AClassToInstrument >> #prototypeTrap) sourceCode.
	prototypeInstrumentedMethod := 'prototypeTrap
    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: [ #beforeAction cull: ''AClassToInstrument>>#prototypeTrap'' ] ].
    [ #originalCodeMethod ] ensure: [
        Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: #afterAction ]. ]'.

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
SourceCodeModificatorProfilerTest >> testInstrumentFollowsPrototypeTrapWithArgs [


	| prototypeInstrumentedMethod originalSourceCode |
	originalSourceCode := (AClassToInstrument >> #prototypeTrap:arg2: ) sourceCode.
	prototypeInstrumentedMethod := 'prototypeTrap: arg1 arg2: arg2
    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: [ #beforeAction cull: ''AClassToInstrument>>#prototypeTrap:arg2:'' ] ].
    [ #originalCodeMethod ] ensure: [
        Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: #afterAction ]. ]'.

	profiler
		beforeAction: '#beforeAction';
		afterAction: '#afterAction';
		addMethods: { (AClassToInstrument >> #prototypeTrap:arg2:) };
		instrument.

	self assert: (AClassToInstrument >> #prototypeTrap:arg2:) sourceCode equals: prototypeInstrumentedMethod.

	profiler uninstrument.
	self assert: originalSourceCode equals: (AClassToInstrument >> #prototypeTrap:arg2:) sourceCode
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testInstrumentWithPragmas [

	| prototypeInstrumentedMethod originalSourceCode |
	originalSourceCode := (AClassToInstrument >> #methodWithPragma) sourceCode.
	prototypeInstrumentedMethod := 'methodWithPragma
<primitive: ''prim'' module: ''InstrumentationProfilers'' error: ''error''>
    Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: [ #beforeAction cull: ''AClassToInstrument>>#methodWithPragma'' ] ].
    [ | var1 var2 |
	var1 := 4.
	var2 := 5.
	self doSomething: error.
	^ 6 ] ensure: [
        Processor activeProcess isMeta ifFalse: [
        Processor activeProcess runInMetaLevel: #afterAction ]. ]'.

	profiler
		beforeAction: '#beforeAction';
		afterAction: '#afterAction';
		addMethods: { (AClassToInstrument >> #methodWithPragma) };
		instrument.

	self assert: (AClassToInstrument >> #methodWithPragma) sourceCode equals: prototypeInstrumentedMethod.

	profiler uninstrument.
	self assert: originalSourceCode equals: (AClassToInstrument >> #methodWithPragma) sourceCode
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfile [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3.

	SingletonClasToTest reset.
	profileBlock value.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 1
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfileMethodWithTempVariables [

	| profileBlock |
	profileBlock := [ AClassToInstrument new tempy ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #tempy) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3.

	SingletonClasToTest reset.
	profileBlock value.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 1
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfileSeveralMethods [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo; bar; poo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #foo) . (AClassToInstrument >> #bar) . (AClassToInstrument >> #poo) };
		profile: profileBlock.

	"foo, bar and poo call one increment"
	self assert: SingletonClasToTest current counter equals: 9.

	SingletonClasToTest reset.
	profileBlock value.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfileSeveralMethodsAndClasses [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo; bar; poo.
		AClassToInstrumentCopy new foo; bar; poo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #foo) . (AClassToInstrument >> #bar) . (AClassToInstrument >> #poo) .
			(AClassToInstrumentCopy >> #foo) . (AClassToInstrumentCopy >> #bar) . (AClassToInstrumentCopy >> #poo) };
		profile: profileBlock.

	"foo, bar and poo call one increment"
	self assert: SingletonClasToTest current counter equals: 18.

	SingletonClasToTest reset.
	profileBlock value.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 6
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfileWithException [

	| profileBlock |
	profileBlock := [ AClassToInstrument new fooWithException ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: afterActionBlock;
		addMethods: { (AClassToInstrument >> #fooWithException) }.

	"Just like method proxies, if the method raises an error, it should be signaled"
	self should: [ profiler profile: profileBlock. ] raise: Error.

	"foo calls one increment but it should not be executed because an exception is signaled"
	"after and before action should be always executed"
	self assert: SingletonClasToTest current counter equals: 2.

	SingletonClasToTest reset.
	"foo calls one increment"
	self should: [ profileBlock value ] raise: Error.
	self assert: SingletonClasToTest current counter equals: 0
]
