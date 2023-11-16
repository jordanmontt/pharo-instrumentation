Class {
	#name : 'PrfProfilerGraphAlgosTest',
	#superclass : 'TestCase',
	#instVars : [
		'profiler'
	],
	#category : 'MethodProfiler-Tests',
	#package : 'MethodProfiler-Tests'
}

{ #category : 'running' }
PrfProfilerGraphAlgosTest >> setUp [

	super setUp.
	profiler := PrfMethodProfiler new
]

{ #category : 'tests' }
PrfProfilerGraphAlgosTest >> testRunGraphAlgosTests [

	| testClasses testSuites packageMethods |
	testClasses := 'AI-Algorithms-Graph-Tests' asPackage definedClasses select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.

	packageMethods := 'AI-Algorithms-Graph' asPackage methods.
	packageMethods do: [ :m | profiler addMethod: m ].

	profiler profile: [ testSuites do: #run ].

	self assert: profiler runner result nodes size equals: 1816.
	self assert: profiler runner result rootNodes size equals: 1
]

{ #category : 'tests' }
PrfProfilerGraphAlgosTest >> testRunGraphAlgosTestsWithRWI [

| testClasses testSuites packageMethods |
	testClasses := 'AI-Algorithms-Graph-Tests' asPackage definedClasses select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.

	packageMethods := 'AI-Algorithms-Graph' asPackage methods.
	profiler useRunWithIn.
	packageMethods do: [ :m | profiler addMethod: m ].

	profiler profile: [ testSuites do: #run ].

	self assert: profiler runner result nodes size equals: 1816.
	self assert: profiler runner result rootNodes size equals: 1
]
