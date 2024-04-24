Class {
	#name : 'IPRunDebuggerModelBench',
	#superclass : 'IPRunAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Run-All',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Run-All'
}

{ #category : 'initialization' }
IPRunDebuggerModelBench >> packagesToInstrument [

	^ {
		  'Debugger-Model' asPackage.
		  'Debugger-Oups' asPackage.
		  'EmergencyDebugger' asPackage }
]

{ #category : 'initialization' }
IPRunDebuggerModelBench >> testPackages [

	^ {
		  'Debugger-Model-Tests' asPackage.
		  'Debugger-Oups-Tests' asPackage.
		  'EmergencyDebugger-Tests' asPackage }
]
