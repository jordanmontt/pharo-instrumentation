Class {
	#name : 'IPDebuggerModelBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'class initialization' }
IPDebuggerModelBench class >> initialize [

	| testClasses |
	methodsToInstrument := self packagesToInstrument flatCollect: #methods as: Set.
	testClasses := (self testPackages flatCollect: #definedClasses) select: [ :e | e isTestCase ].
	testSuites := testClasses collect: #suite.
]

{ #category : 'benchmarking' }
IPDebuggerModelBench class >> packagesToInstrument [

	^ {
		  'Debugger-Model' asPackage.
		  'Debugger-Oups' asPackage.
		  'EmergencyDebugger' asPackage }
]

{ #category : 'benchmarking' }
IPDebuggerModelBench class >> testPackages [

	^ {
		  'Debugger-Model-Tests' asPackage.
		  'Debugger-Oups-Tests' asPackage.
		  'EmergencyDebugger-Tests' asPackage }
]
