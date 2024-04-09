"
I'm a modern implementation of Python's method decorators or MethodWrappers for Pharo based on `valueWithReceiver:arguments:` VM hook.
Method proxies are objects that wrap methods stored in the method dictionary of the class. 
Some support before and after action the execution of the original method. 
Method proxies control their installation and propagation. 
In particular, they can be applied to any Pharo method. The implementation ensures that the method proxy installation cannot touch any part of the system that could be used to installation.
Method proxies delegate to method handler. This delegation ensures that end user cannot blow up their environment by overridding undesired methods.
## Usage
Here is a typical usage. Check the tests to know more. 
```
testCounts
	| proxy instance handler |
	[ proxy := MpMethodProxy
		on: #methodOne
		inClass: MpClassA
		handler: (handler := MwCountingHandler new).
	proxy install.
	instance := MpClassA new.
	self assert: handler count equals: 0.
	instance methodOne.
	self assert: handler count equals: 1.
	instance methodOne.
	self assert: handler count equals: 2 ] ensure: [ proxy uninstall ]
```
This package is developed and maintained by S. Ducasse, G. Polito and P. Tesone, but feel free to give a hand. 
"
Class {
	#name : 'RWIMethodProxy',
	#superclass : 'Object',
	#instVars : [
		'selector',
		'methodClass',
		'isDisabled',
		'handler',
		'proxifiedMethod'
	],
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'reflective operations' }
RWIMethodProxy class >> doesNotUnderstand: aMessage [

	^ CompiledMethod 
		  perform: aMessage selector
		  withArguments: aMessage arguments
]

{ #category : 'instance creation' }
RWIMethodProxy class >> on: selector inClass: aClass handler: aHandler [

	| proxy |
	proxy := self new.
	proxy class: aClass selector: selector.
	proxy handler: aHandler.
	^ proxy
]

{ #category : 'instance creation' }
RWIMethodProxy class >> onMethod: aMethod handler: aHandler [

	^ self on: aMethod selector inClass: aMethod methodClass handler: aHandler
]

{ #category : 'private' }
RWIMethodProxy class >> uninstallAllWrappers [
	"self uninstallAllWrappers"

	self allSubInstancesDo: [ :inst | inst uninstall ]
]

{ #category : 'comparing' }
RWIMethodProxy >> = anObject [
	"Answer whether the receiver and the argument represent the same
	object. If = is redefined in any subclass, consider also redefining the
	message hash."

	^ self == anObject
]

{ #category : 'accessing' }
RWIMethodProxy >> calypsoEnvironmentType [
	^ proxifiedMethod 
			ifNotNil: [ proxifiedMethod calypsoEnvironmentType ]
			ifNil: [ super calypsoEnvironmentType ]
			
]

{ #category : 'initialization' }
RWIMethodProxy >> class: aClass selector: aSymbol [

	self
		methodClass: aClass;
		selector: aSymbol
]

{ #category : 'accessing' }
RWIMethodProxy >> disable [

	isDisabled := true
]

{ #category : 'accessing' }
RWIMethodProxy >> doesNotUnderstand: aMessage [
	^ proxifiedMethod 
			ifNotNil: [ proxifiedMethod 
								perform: aMessage selector 
								withArguments: aMessage arguments ]
			ifNil: [ super doesNotUnderstand: aMessage ]
			
]

{ #category : 'accessing' }
RWIMethodProxy >> fetchMethod [
	
	"Fetches the method to be instrumented"
	^ methodClass >> selector
]

{ #category : 'installation' }
RWIMethodProxy >> handler [

	^ handler
]

{ #category : 'accessing' }
RWIMethodProxy >> handler: aHandler [

	handler := aHandler
]

{ #category : 'installation' }
RWIMethodProxy >> initialize [

	super initialize.
	isDisabled := true
]

{ #category : 'installation' }
RWIMethodProxy >> install [
	"We have a method proxy with a method = class * selector of the method it will proxy."
	
	|  method |
	method := methodClass compiledMethodAt: selector ifAbsent: [ 
		RWICannotInstall signalWith: self ].
	
	(self shouldWrap: method) ifFalse: [ 
		RWICannotInstall signalWith: self ].
	
	self unproxifiedMethod: method.
	methodClass methodDict at: selector put: self.
	
	"Activate it now"
	isDisabled := false.
	^ self
]

{ #category : 'accessing' }
RWIMethodProxy >> isEnabled [

	^ isDisabled not
]

{ #category : 'accessing' }
RWIMethodProxy >> isEnabled: anObject [

	isDisabled := anObject not
]

{ #category : 'testing' }
RWIMethodProxy >> isInstalled [
	"Return whether the receiver is effectively installed in a method dictionary.
	Note that in the case of nesting of method proxies the inner ones are not considered as installed."
	
	methodClass ifNotNil: [
		selector ifNotNil: [ 
			^ self == (methodClass methodDict at: selector ifAbsent: [])]].
	^ false
]

{ #category : 'testing' }
RWIMethodProxy >> isMethodProxy [

	^ true
]

{ #category : 'accessing' }
RWIMethodProxy >> methodClass [
	^ methodClass
]

{ #category : 'accessing' }
RWIMethodProxy >> methodClass: aClass [

	methodClass := aClass
]

{ #category : 'evaluating' }
RWIMethodProxy >> name [

	^ self printString
]

{ #category : 'printing' }
RWIMethodProxy >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: '[';
		nextPutAll: methodClass name;
		nextPutAll: '>>#';
		nextPutAll: selector;
		nextPutAll: ']'
]

{ #category : 'evaluating' }
RWIMethodProxy >> receiver: aReceiver withArgs: argArray executeMethod: compiledMethod [
	"Execute compiledMethod against the receiver and args in argArray"

	<primitive: 188>
	<methodProxyCannotWrap>
	self primitiveFailed
]

{ #category : 'evaluating' }
RWIMethodProxy >> run: aSelector with: anArrayOfObjects in: aReceiver [
	"Do not intercept"

	<methodProxyCannotWrap>
	(isDisabled or: [ thisProcess isMeta ]) ifTrue: [
		^ self
			  receiver: aReceiver
			  withArgs: anArrayOfObjects
			  executeMethod: proxifiedMethod ].

	"Purposely do not use a non-local return.
	Otherwise the non-local return logic would be instrumented once the ensure block is executed.
	However, since a lot of code executes between the ensure block and the real method return, this could end in infinite loops"
	^ self valueWithReceiver: aReceiver arguments: anArrayOfObjects
]

{ #category : 'accessing' }
RWIMethodProxy >> selector [

	^ selector
]

{ #category : 'accessing' }
RWIMethodProxy >> selector: aSymbol [

	selector := aSymbol
]

{ #category : 'installation' }
RWIMethodProxy >> shouldWrap: aMethod [

	(aMethod isCompiledMethod not and: [
		 aMethod handler class ~~ self handler class ]) ifTrue: [ ^ true ].

	aMethod isCompiledMethod ifFalse: [ ^ false ].

	^ aMethod pragmas noneSatisfy: [ :pragma |
		  pragma selector = #methodProxyCannotWrap or: [
			  pragma selector = #noInstrumentation ] ]
]

{ #category : 'installation' }
RWIMethodProxy >> uninstall [

	| installedMethod |
	thisProcess runInMetaLevel: [
		installedMethod := methodClass
			                   compiledMethodAt: selector
			                   ifAbsent: [ ^ self ].
		installedMethod == self ifTrue: [
			methodClass methodDict
				at: selector
				put: installedMethod wrappedMethod ].
		self unproxifiedMethod: nil ]
]

{ #category : 'accessing' }
RWIMethodProxy >> unproxifiedMethod [
	"The unproxifedMethod returns the proxified method even in case we have multiple proxified nesting."
	
	^ proxifiedMethod ifNotNil: [ proxifiedMethod unproxifiedMethod ]
]

{ #category : 'when installed' }
RWIMethodProxy >> unproxifiedMethod: aCompiledMethod [

	proxifiedMethod := aCompiledMethod
]

{ #category : 'evaluating' }
RWIMethodProxy >> valueWithReceiver: receiver arguments: arguments [

	<methodProxyCannotWrap>
	| result |
	"Hooking into user methods to define before actions.
	Before actions are not instrumented."
	thisProcess runInMetaLevel: [
		handler beforeExecutionWithReceiver: receiver arguments: arguments ].

	"Purposely do not use a non-local return.
	Otherwise the non-local return logic would be instrumented and this could end in infinite loops"
	[
	result := self
		          receiver: receiver
		          withArgs: arguments
		          executeMethod: proxifiedMethod ] methodProxyEnsure:
		(RWIInstrumentationUnwinder
			 newWithHandler: handler
			 receiver: receiver
			 arguments: arguments).

	thisProcess runInMetaLevel: [^ handler
		  afterExecutionWithReceiver: receiver
		  arguments: arguments
		  returnValue: result]
]

{ #category : 'accessing' }
RWIMethodProxy >> wrappedClass [

	^ methodClass
]

{ #category : 'accessing' }
RWIMethodProxy >> wrappedClass: aClass [

	methodClass := aClass
]

{ #category : 'when installed' }
RWIMethodProxy >> wrappedMethod [

	^ proxifiedMethod
]
