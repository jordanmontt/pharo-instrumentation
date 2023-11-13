"
```st
| testClasses testSuites packageMethods profiler classes |
classes := 'AI-Algorithms-Graph-Tests' asPackage definedClasses.
testClasses := classes select: [ :e | e isTestCase ].
testSuites := testClasses collect: #suite.

packageMethods :=classes flatCollect: #methods.

profiler := PrfMethodProfiler new.
profiler useRunWithIn.
packageMethods do: [ :m | profiler addMethod: m ].

profiler profile: [ testSuites do: #run ].
profiler
```
"
Class {
	#name : 'PrfMethodProfiler',
	#superclass : 'Object',
	#instVars : [
		'methods',
		'lastRunner',
		'useRunWithIn'
	],
	#classVars : [
		'FinalizationReg'
	],
	#category : 'MethodProfiler-Core',
	#package : 'MethodProfiler',
	#tag : 'Core'
}

{ #category : 'class initialization' }
PrfMethodProfiler class >> initialize [ 
	FinalizationReg := FinalizationRegistry new. 
]

{ #category : 'installation' }
PrfMethodProfiler class >> shouldWrap: aMethod [

	| unproxifiedMethod |
	unproxifiedMethod := aMethod unproxifiedMethod.

	unproxifiedMethod isCompiledMethod ifFalse: [ ^ false ].

	unproxifiedMethod realClass package = self package ifTrue: [ ^ false ].

	(unproxifiedMethod pragmas noneSatisfy: [ :pragma |
		 pragma selector = #methodProxyCannotWrap ]) ifFalse: [ ^ false ].

	^ true
]

{ #category : 'installation' }
PrfMethodProfiler >> addClass: aClass [

	aClass methodDictionary do: [ :method | self addMethod: method unproxifiedMethod ]
]

{ #category : 'installation' }
PrfMethodProfiler >> addMethod: aMethod [

	| unproxifiedMethod |
	unproxifiedMethod := aMethod unproxifiedMethod.
	(self class shouldWrap: unproxifiedMethod) ifTrue: [ methods add: unproxifiedMethod ]
]

{ #category : 'installation' }
PrfMethodProfiler >> addPackage: aPackage [

	aPackage definedClasses do: [ :class | self addClass: class ]
]

{ #category : 'as yet unclassified' }
PrfMethodProfiler >> createRunner [

	lastRunner := useRunWithIn
		ifTrue: [ PrfMethodProfilerRunner newRWIForMethods: methods ]
		ifFalse: [ PrfMethodProfilerRunner newForMethods: methods ].
	FinalizationReg add: self.
	^ lastRunner
]

{ #category : 'initialization' }
PrfMethodProfiler >> doNotUseRunWithIn [

	useRunWithIn := false
]

{ #category : 'installation' }
PrfMethodProfiler >> excludeClass: aClass [

	aClass methodDictionary do: [ :method | self excludeMethod: method ]
]

{ #category : 'installation' }
PrfMethodProfiler >> excludeMethod: aMethod [

	| unproxifiedMethod |
	unproxifiedMethod := aMethod unproxifiedMethod.
	(methods includes: unproxifiedMethod)
		ifTrue: [ methods remove: unproxifiedMethod ]
]

{ #category : 'installation' }
PrfMethodProfiler >> excludePackage: aPackage [

	aPackage classes do: [ :class | self excludeClass: class ]
]

{ #category : 'as yet unclassified' }
PrfMethodProfiler >> finalize [

	lastRunner destroy
]

{ #category : 'initialization' }
PrfMethodProfiler >> initialize [

	methods := Set new.
	self doNotUseRunWithIn
]

{ #category : 'installation' }
PrfMethodProfiler >> isProfilingMethod: aMethod [

	^ methods includes: aMethod unproxifiedMethod
]

{ #category : 'accessing' }
PrfMethodProfiler >> profile: aBlock [

	^ self createRunner profile: aBlock
]

{ #category : 'initialization' }
PrfMethodProfiler >> useRunWithIn [

	useRunWithIn := true
]
