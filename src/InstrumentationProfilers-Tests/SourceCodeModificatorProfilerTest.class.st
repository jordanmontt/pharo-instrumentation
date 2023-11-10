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
SourceCodeModificatorProfilerTest >> testProfileWithException [

	| profileBlock |
	profileBlock := [ AClassToInstrument new fooWithException ].

	profiler
		beforeAction: [ SingletonClasToTest current increment ];
		afterAction: [ SingletonClasToTest current increment ];
		addMethods: { (AClassToInstrument >> #foo) };
		profile: profileBlock.

	"foo calls one increment but it should not be executed because an exception is signaled"
	self assert: SingletonClasToTest current counter equals: 2.

	SingletonClasToTest reset.
	"foo calls one increment"
	self should: profileBlock value raise: Exception.
	self assert: SingletonClasToTest current counter equals: 0
]
