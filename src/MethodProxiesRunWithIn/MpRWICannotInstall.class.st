Class {
	#name : 'MpRWICannotInstall',
	#superclass : 'Error',
	#instVars : [
		'methodProxy'
	],
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'signalling' }
MpRWICannotInstall class >> signalWith: aMethodProxy [

	self new
		methodProxy: aMethodProxy;
		signal
]

{ #category : 'accessing' }
MpRWICannotInstall >> methodProxy [

	^ methodProxy
]

{ #category : 'accessing' }
MpRWICannotInstall >> methodProxy: anObject [

	methodProxy := anObject
]
