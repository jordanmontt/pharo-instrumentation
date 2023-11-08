"
```
| testClasses testSuites classes packageMethods profiler |
classes := 'AI-Algorithms-Graph' asPackage definedClasses.
testClasses := classes select: [ :e | e isTestCase ].
testSuites := testClasses collect: #suite.

profiler := Spy2CallGraphProfiler new.
profiler startOnClasses: classes.

testSuites do: #run.

profiler stop.
```
"
Class {
	#name : 'Spy2CallGraphProfiler',
	#superclass : 'S2Profiler',
	#instVars : [
		'callStack'
	],
	#category : 'InstrumentationProfilers-Spy2',
	#package : 'InstrumentationProfilers',
	#tag : 'Spy2'
}

{ #category : 'hooks' }
Spy2CallGraphProfiler class >> spyClassForPackage [
	^ Spy2CallGraphPackage
]

{ #category : 'initialization' }
Spy2CallGraphProfiler >> initialize [

	super initialize.
	callStack := Stack new.
	callStack push: (Spy2CallGraphMethod new
		selector: #root;
		yourself)
]

{ #category : 'hooks' }
Spy2CallGraphProfiler >> registryName [

	^ #Spy2CallGraphProfiler
]

{ #category : 'hooks' }
Spy2CallGraphProfiler >> stack [

	^ callStack
]
