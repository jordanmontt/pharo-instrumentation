Class {
	#name : 'RWICannotInstall',
	#superclass : 'Error',
	#instVars : [
		'methodProxy'
	],
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'signalling' }
RWICannotInstall class >> signalWith: aMethodProxy [

	self new
		methodProxy: aMethodProxy;
		signal
]

{ #category : 'accessing' }
RWICannotInstall >> methodProxy [

	^ methodProxy
]

{ #category : 'accessing' }
RWICannotInstall >> methodProxy: anObject [

	methodProxy := anObject
]
