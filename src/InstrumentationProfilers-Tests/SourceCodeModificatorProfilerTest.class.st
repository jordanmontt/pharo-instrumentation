"
A SourceCodeModificatorProfilerTest is a test class for testing the behavior of SourceCodeModificatorProfiler
"
Class {
	#name : 'SourceCodeModificatorProfilerTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler',
		'beforeActionBlock'
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
	beforeActionBlock := [ :method | 'SingletonClasToTest current increment' ]
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

	self skip: 'Skiping because the profiler does not uninstrument when the after raises an error'.

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

	self skip: 'Skiping because the profiler does not uninstrument when the before raises an error'.

	profiler
		beforeAction: [ :method | 'Error signal' ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) }.

	self should: [profiler profile: profileBlock ] raise: Error.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 2
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testInstrument [

	| profileBlock originalSourceCode |
	profileBlock := [ AClassToInstrument new foo ].
	originalSourceCode := (AClassToInstrument >> #foo) sourceCode.

	profiler
		beforeAction: beforeActionBlock;
		afterAction: [ SingletonClasToTest current increment ];
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
SourceCodeModificatorProfilerTest >> testProfile [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: [ SingletonClasToTest current increment ];
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
SourceCodeModificatorProfilerTest >> testProfileSeveralMethods [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo; bar; poo ].

	profiler
		beforeAction: beforeActionBlock;
		afterAction: [ SingletonClasToTest current increment ];
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
		afterAction: [ SingletonClasToTest current increment ];
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
		afterAction: [ SingletonClasToTest current increment ];
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
