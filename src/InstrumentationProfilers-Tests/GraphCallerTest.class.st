Class {
	#name : 'GraphCallerTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler',
		'packageMethods',
		'profilingBlock'
	],
	#category : 'InstrumentationProfilers-Tests',
	#package : 'InstrumentationProfilers-Tests'
}

{ #category : 'tests' }
GraphCallerTest >> assertNodes [

	| rootNode |
	self assert: profiler nodes size equals: 142.
	self assert: profiler methodProxies size equals: packageMethods size.
	self
		assert: (profiler nodes values sum: [ :node | node timesCalled ])
		equals: 28630.
	rootNode := (profiler nodes values select: [ :e | e method = #root ]) first.
	self assert: rootNode timesCalled equals: 0.
	self
		assert: rootNode methodCalls size
		equals: 685
]

{ #category : 'running' }
GraphCallerTest >> setUp [

	| testClasses testSuites |
	super setUp.

	testClasses := 'AI-Algorithms-Graph-Tests' asPackage definedClasses
		select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
	packageMethods := 'AI-Algorithms-Graph' asPackage methods.
	profilingBlock := [ testSuites do: #run ]
]

{ #category : 'tests' }
GraphCallerTest >> testMethodProxiesProfiler [

	profiler := MpCallGraphProfiler new.
	profiler addMethods: packageMethods.
	profiler profile: profilingBlock.

	self assertNodes
]

{ #category : 'tests' }
GraphCallerTest >> testRunWithInProfiler [

	profiler := RWICallGraphProfiler new.
	profiler addMethods: packageMethods.
	profiler profile: profilingBlock.

	self assertNodes
]
