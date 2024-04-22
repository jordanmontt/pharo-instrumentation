Class {
	#name : 'IPDebuggerModelBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPDebuggerModelBench >> packagesToInstrument [

	^ {
		  'Debugger-Model' asPackage.
		  'Debugger-Oups' asPackage.
		  'EmergencyDebugger' asPackage }
]

{ #category : 'initialization' }
IPDebuggerModelBench >> testPackages [

	^ {
		  'Debugger-Model-Tests' asPackage.
		  'Debugger-Oups-Tests' asPackage.
		  'EmergencyDebugger-Tests' asPackage }
]
