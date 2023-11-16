Class {
	#name : 'GraphCallerTest',
	#superclass : 'TestCase',
	#instVars : [
		'packageMethods',
		'profilingBlock',
		'mpProfiler',
		'rwiProfiler'
	],
	#category : 'InstrumentationProfilers-Tests-CallGraph',
	#package : 'InstrumentationProfilers-Tests',
	#tag : 'CallGraph'
}

{ #category : 'tests' }
GraphCallerTest >> assertProfilersReturnSameResults [

	| mpRootNode rwiRootNode |
	self assert: mpProfiler nodes size equals: rwiProfiler nodes size.

	self assert: mpProfiler methodProxies size equals: packageMethods size.
	self assert: rwiProfiler methodProxies size equals: packageMethods size.

	self
		assert: (mpProfiler nodes values sum: [ :node | node timesCalled ])
		equals: (rwiProfiler nodes values sum: [ :node | node timesCalled ]).
	
	mpRootNode := (mpProfiler nodes values select: [ :e | e method = #root ]) first.
	rwiRootNode := (rwiProfiler nodes values select: [ :e | e method = #root ]) first.

	self assert: mpRootNode timesCalled equals: 0.
	self assert: rwiRootNode timesCalled equals: 0.
	self assert: mpRootNode methodCalls size equals: rwiRootNode methodCalls size
]

{ #category : 'running' }
GraphCallerTest >> setMethodsToInstrumentFor: packages [

	packageMethods := packages flatCollect: #methods as: Set
]

{ #category : 'tests' }
GraphCallerTest >> setMpProfiler [

	mpProfiler := MpCallGraphProfiler new.
	mpProfiler addMethods: packageMethods.
	mpProfiler profile: profilingBlock
]

{ #category : 'running' }
GraphCallerTest >> setProfilingBlockForTests: testPackages [

	| testClasses testSuites |
	testClasses := (testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
	profilingBlock := [ testSuites do: #run ]
]

{ #category : 'tests' }
GraphCallerTest >> setRWIProfiler [

	rwiProfiler := RWICallGraphProfiler new.
	rwiProfiler addMethods: packageMethods.
	rwiProfiler profile: profilingBlock
]

{ #category : 'tests' }
GraphCallerTest >> testFuzzyMatcher [

	self setProfilingBlockForTests: { 'FuzzyMatcher-Tests' asPackage }.
	self setMethodsToInstrumentFor: { 'FuzzyMatcher' asPackage }.
	
	self setMpProfiler.
	self setRWIProfiler.

	self assertProfilersReturnSameResults
]

{ #category : 'tests' }
GraphCallerTest >> testGraphAlgos [

	self setProfilingBlockForTests: { 'AI-Algorithms-Graph-Tests' asPackage }.
	self setMethodsToInstrumentFor: { 'AI-Algorithms-Graph' asPackage }.

	self setMpProfiler.
	self setRWIProfiler.

	self assertProfilersReturnSameResults
]

{ #category : 'tests' }
GraphCallerTest >> testMicrodown [

	self setProfilingBlockForTests: { 'Microdown-Tests' asPackage }.
	self setMethodsToInstrumentFor: { 'Microdown' asPackage . 'Microdown-RichTextComposer' asPackage }.
	
	self setMpProfiler.
	self setRWIProfiler.

	self assertProfilersReturnSameResults
]

{ #category : 'tests' }
GraphCallerTest >> testProfStef [

	self setProfilingBlockForTests: { 'ProfStef-Tests' asPackage }.
	self setMethodsToInstrumentFor: { 'ProfStef-Core' asPackage }.
	
	self setMpProfiler.
	self setRWIProfiler.

	self assertProfilersReturnSameResults
]

{ #category : 'tests' }
GraphCallerTest >> testRewriteTool [

	self setProfilingBlockForTests: { 'NewTools-RewriterTools-Tests' asPackage .
		'NewTools-RewriterTools-Backend-Tests' asPackage }.
	self setMethodsToInstrumentFor: { 'NewTools-RewriterTools-Backend' asPackage .
		'NewTools-RewriterTools' asPackage }.
	
	self setMpProfiler.
	self setRWIProfiler.

	self assertProfilersReturnSameResults
]
