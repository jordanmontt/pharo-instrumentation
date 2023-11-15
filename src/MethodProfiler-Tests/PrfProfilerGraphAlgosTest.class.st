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

	| testClasses testSuites packageMethods classes |
	classes := 'AI-Algorithms-Graph-Tests' asPackage definedClasses.
	testClasses := classes select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.

	packageMethods := classes flatCollect: #methods.

	packageMethods do: [ :m | profiler addMethod: m ].

	profiler profile: [ testSuites do: #run ].

	self assert: profiler runner result nodes size equals: 1816.
	self assert: profiler runner result rootNodes size equals: 1
]

{ #category : 'tests' }
PrfProfilerGraphAlgosTest >> testRunGraphAlgosTestsWithRWI [

	| testClasses testSuites packageMethods classes |
	classes := 'AI-Algorithms-Graph-Tests' asPackage definedClasses.
	testClasses := classes select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.

	packageMethods := classes flatCollect: #methods.

	profiler useRunWithIn.
	packageMethods do: [ :m | profiler addMethod: m ].

	profiler profile: [ testSuites do: #run ].

	self assert: profiler runner result nodes size equals: 1816.
	self assert: profiler runner result rootNodes size equals: 1
]
