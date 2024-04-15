Class {
	#name : 'IPDebuggerModelBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

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
