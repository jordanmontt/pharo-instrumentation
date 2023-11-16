"
A SourceCodeModificatorProfilerTest is a test class for testing the behavior of SourceCodeModificatorProfiler
"
Class {
	#name : 'SourceCodeModificatorProfilerTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler'
	],
	#category : 'InstrumentationProfilers-Tests',
	#package : 'InstrumentationProfilers-Tests'
}

{ #category : 'running' }
SourceCodeModificatorProfilerTest >> setUp [

	super setUp.

	SingletonClasToTest reset.
	profiler := SourceCodeModificatorProfiler new
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testAfterHasLocalReturn [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [SingletonClasToTest current increment ];
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

	profiler
		beforeAction: [ SingletonClasToTest current increment ];
		afterAction: [ Error signal ];
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 2
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testBeforeHasLocalReturn [

	| profileBlock |
	self flag: 'I do not know if it makes sense to check this case.
	Why whould the beforeMethod will have a non local return?'.
	self skip.
	
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [SingletonClasToTest current increment. ^ 5 ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testBeforeRaisesError [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [ Error signal ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 2
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testInstrument [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [ SingletonClasToTest current increment ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) };
		instrument.

	profileBlock value.

	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 3.

	profiler uninstrument.
	SingletonClasToTest reset.
	profileBlock value.
	"foo calls one increment"
	self assert: SingletonClasToTest current counter equals: 1
]

{ #category : 'tests' }
SourceCodeModificatorProfilerTest >> testProfile [

	| profileBlock |
	profileBlock := [ AClassToInstrument new foo ].

	profiler
		beforeAction: [ SingletonClasToTest current increment ];
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
		beforeAction: [ SingletonClasToTest current increment ];
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
		beforeAction: [ SingletonClasToTest current increment ];
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
		beforeAction: [ SingletonClasToTest current increment ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #fooWithException) };
		profile: profileBlock.

	"foo calls one increment but it should not be executed because an exception is signaled"
	"after and before action should be always executed"
	self assert: SingletonClasToTest current counter equals: 2.

	SingletonClasToTest reset.
	"foo calls one increment"
	self should: [ profileBlock value ] raise: Error.
	self assert: SingletonClasToTest current counter equals: 0
]
