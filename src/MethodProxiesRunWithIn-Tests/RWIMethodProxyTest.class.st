Class {
	#name : 'RWIMethodProxyTest',
	#superclass : 'TestCase',
	#instVars : [
		'trackedWrappers'
	],
	#category : 'MethodProxiesRunWithIn-Tests',
	#package : 'MethodProxiesRunWithIn-Tests'
}

{ #category : 'asserting' }
RWIMethodProxyTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> assertCannotInstall: mp [

	[mp install.
	self fail.]
		on: RWICannotInstall do: [ :ex |
			self assert: ex methodProxy equals: mp ]
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> callEnsureWithNonLocalReturn [
	
	[ ^ 7 ] ensure: [ 2 ]
]

{ #category : 'hook' }
RWIMethodProxyTest >> handlerClass [ 
	^ MpHandler
]

{ #category : 'tests - dead representation' }
RWIMethodProxyTest >> installMethodProxy: aMethodProxy [

	trackedWrappers add: aMethodProxy.
	aMethodProxy install.

]

{ #category : 'initialization' }
RWIMethodProxyTest >> setUp [ 

	super setUp.
	trackedWrappers := OrderedCollection new.
	RWIClassA methods do: [ :each | each uninstall ]
	
]

{ #category : 'initialization' }
RWIMethodProxyTest >> tearDown [

	trackedWrappers do: [ :e | e uninstall ].
	super tearDown
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanRunConcurrently [
	"This tests the ability of method proxies to not influence each other between threads."
	| mp1 mp2 mpTrigger1 mpTrigger2 handlerTrigger1 handlerTrigger2 sharedObject testSemaphore |

	sharedObject := RWITestConcurrentSharedObject new.
	testSemaphore := Semaphore new.

	mp1 := RWIMethodProxy onMethod: (RWITestConcurrentSharedObject lookupSelector: #methodProcess1) handler: (RWIWaitBeforeHandler new).
	mp2 := RWIMethodProxy onMethod: (RWITestConcurrentSharedObject lookupSelector: #methodProcess2) handler: (RWIWaitAndTriggerBeforeHandler new).
	mpTrigger1 := RWIMethodProxy onMethod: (RWITestConcurrentSharedObject lookupSelector: #trigger1) handler: (handlerTrigger1 := RWIAfterCounterHandler new).
	mpTrigger2 := RWIMethodProxy onMethod: (RWITestConcurrentSharedObject lookupSelector: #trigger2) handler: (handlerTrigger2 := RWIAfterCounterHandler new).

	self installMethodProxy: mp1.
	self installMethodProxy: mp2.
	self installMethodProxy: mpTrigger1.
	self installMethodProxy: mpTrigger2.

	"Here the first process will run an instrumented trigger (trigger1) while the second process is not instrumenting, then the second process will run a non-instrumented trigger while the first process is still instrumenting."
	[ sharedObject methodProcess1. testSemaphore signal ] fork.
	[ sharedObject methodProcess2. testSemaphore signal ] fork.
	testSemaphore wait.

	"Here the first trigger should have been captured, but not the second. If not concurrency is not correctly managed."
	self assert: handlerTrigger1 count equals: 1.
	self assert: handlerTrigger2 count equals: 0
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapAboutToReturnThroughWithNonLocalReturn [

	| mp handler |
	mp := RWIMethodProxy onMethod: Context >> #aboutToReturn:through: handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	self callEnsureWithNonLocalReturn.

	self assert: handler count equals: 1
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapBasicNew [

	| mp handler |
	mp := RWIMethodProxy onMethod: Behavior >> #basicNew handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	RWIClassA new.

	self assert: handler count equals: 1
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapEnsure [

	| mp handler |
	mp := RWIMethodProxy onMethod: BlockClosure >> #ensure: handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	[ 1 ] ensure: [ 2 ].

	self assert: handler count equals: 1
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapEnsureNonLocalReturn [

	| mp handler |
	mp := RWIMethodProxy onMethod: BlockClosure >> #ensure: handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	self callEnsureWithNonLocalReturn.

	self assert: handler count equals: 1
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapEnsureWithException [

	| mp handler |
	mp := RWIMethodProxy onMethod: BlockClosure >> #ensure: handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	[[ 1 error ] ensure: [ 2 ]] on: Error do: [ "nothing" ].

	self assert: handler count equals: 1
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapValue [
	<compilerOptions: #(- optionConstantBlockClosure)>
	| mp handler |
	mp := RWIMethodProxy onMethod: (FullBlockClosure lookupSelector: #value) handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	[[ 1 ] value] value.

	self assert: handler count equals: 2
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCanWrapValueWithException [

	| mp handler |
	mp := RWIMethodProxy onMethod: (FullBlockClosure lookupSelector: #value) handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	[[[ 1 error ] value] value] on: Error do: #yourself "to avoid an extra block".

	self assert: handler count equals: 2 "value" + 1 "on:do:"
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testCannotProxyUnexistentMethod [

	| mp |
	mp := RWIMethodProxy on: #methodOne inClass: Object handler: self handlerClass new.
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods [

	| mp handler |
	mp := RWIMethodProxy onMethod: RWIMethodProxy >> #run:with:in: handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods2 [

	| mp handler |
	mp := RWIMethodProxy onMethod: RWIMethodProxy >> #receiver:withArgs:executeMethod: handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods3 [

	| mp handler |
	mp := RWIMethodProxy onMethod: RWIMethodProxy >> #run:with:in: handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods4 [

	| mp handler |
	mp := RWIMethodProxy onMethod: BlockClosure >> #methodProxiesEnsure: handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods5 [

	| mp handler |
	mp := RWIMethodProxy onMethod: RWIInstrumentationUnwinder >> #value handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testCannotWrapCriticalProxyMethods6 [

	| mp handler |
	mp := RWIMethodProxy onMethod: InstrumentationDeactivator >> #value handler: (handler := RWICountingHandler new).
	
	self assertCannotInstall: mp
]

{ #category : 'tests - dead representation' }
RWIMethodProxyTest >> testCreatingAnInstanceDoesNotInstallIt [

	| mp method |
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	self assert: mp selector equals: #methodOne.
	self assert: mp methodClass equals: RWIClassA.

	self assert: mp wrappedMethod equals: nil
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testExceptionsAfterInstrumentationDoNotBreakInstrumentation [

	| mp handler |
	mp := RWIMethodProxy onMethod: Object >> #error: handler: (handler := RWICountingHandler new).
	
	self installMethodProxy: mp.

	"An error after instrumentation should not break the instrumentation.
	Subsequent calls should still be instrumented, and the counting code should still execute regardless the exception"
	2 timesRepeat: [
		[RWIClassB new error: 'error after instrumentation'.
		self fail] on: Error do: [ :error | ] ].

	self assert: handler count equals: 2
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testExceptionsAfterInstrumentationFlow [
"Managing exceptions in the wrapper"
	| p |
	p := RWIMethodProxy onMethod: Object >> #error: handler: RWICountingHandler new.
	
	self installMethodProxy: p.

	"An error after instrumentation should not break the instrumentation.
	Subsequent calls should still be instrumented"
	2 timesRepeat: [
		[ RWIClassB new error: 'error after instrumentation'.
		self fail ]
			on: Error do: [ :error |
				self assert: error messageText equals: 'error after instrumentation' ].]
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testExceptionsDuringInstrumentationDoNotBreakInstrumentation [
"Managing exceptions in the wrapper"
	| w |
	w := RWIMethodProxy onMethod: RWIClassB >> #methodTwo  handler: RWIFailingHandlerMock new.
	
	self installMethodProxy: w.

	"An error during instrumentation should not break the instrumentation.
	Subsequent calls should still be instrumented"
	2 timesRepeat: [
		[RWIClassB new methodTwo.
		self fail]
			on: Error do: [ :error |
				self assert: error messageText equals: 'error during instrumentation' ].]
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testInstallSetCompiledMethod [

	| mw method |
	[ 
	method := RWIClassA >> #methodOne.
	mw := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mw install.
	self assert: mw selector equals: #methodOne.
	self assert: mw methodClass equals: RWIClassA.
	self assert: mw wrappedMethod equals: method ] ensure: [ 
		mw uninstall ]
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testIsInstalled [

	| mw method |
	[ 
	method := RWIClassA >> #methodOne.
	mw := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	self deny: mw isInstalled.
	mw install.
	self assert: mw isInstalled ] ensure: [ mw uninstall ]
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testIsInstalledNestedMWAreNotInstalled [

	| mp method mp2 |
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp2 := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: RWIMockMethodProxyHandler new.
	mp install.
	mp2 install.
	self deny: mp isInstalled.
	self assert: mp2 isInstalled.
	mp2 uninstall.
	self deny: mp2 isInstalled.
	self assert: mp isInstalled.
	mp uninstall.
	self deny: mp isInstalled
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testRecursiveMethodWrapperDoesNotRecurse [

	| mw method |
	method := RWIMockObject >> #recursiveMethod.
	mw := RWIMethodProxy onMethod: method  handler: RWIMockMethodProxyHandler new.
	self installMethodProxy: mw.

	self assert: RWIMockObject new recursiveMethod equals: 'trapped [original]'.
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testUninstall [

	| mp method |
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp install.
	self assert: (RWIClassA compiledMethodAt: #methodOne) isMethodProxy.
	self assert: (RWIClassA compiledMethodAt: #methodOne) == mp.
	mp uninstall.
	self assert: (RWIClassA compiledMethodAt: #methodOne) == method.
	self assert: mp wrappedMethod isNil
]

{ #category : 'tests - installation' }
RWIMethodProxyTest >> testUninstallNestedInRightOrderIsOk [

	| mp mp2 method |
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp2 := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: RWIMockMethodProxyHandler new.
	mp install.
	mp2 install.
	self assert: (RWIClassA compiledMethodAt: #methodOne) isMethodProxy.
	self assert: (RWIClassA compiledMethodAt: #methodOne) identicalTo: mp2.
	mp2 uninstall.
	self assert: (RWIClassA compiledMethodAt: #methodOne) identicalTo: mp.
	mp uninstall.
	self
		assert: (RWIClassA compiledMethodAt: #methodOne)
		identicalTo: method
]

{ #category : 'tests' }
RWIMethodProxyTest >> testUnwrappedMethodAtOneLevelIsTheWrappedMethod [

	| mp method |
	[ 
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp install.
	self assert: mp unproxifiedMethod equals: method ] ensure: [ 
		mp uninstall ]
]

{ #category : 'tests' }
RWIMethodProxyTest >> testUnwrappedMethodOfNestedMethodWrapperInTheCompiledMethod [

	| mp method mp2 |
	[ 
	method := RWIClassA >> #methodOne.
	mp := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp install.
	mp2 := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: RWIMockMethodProxyHandler new.
	mp2 install.

	self assert: mp2 wrappedMethod equals: mp.
	self assert: mp2 unproxifiedMethod equals: method ] ensure: [ 
		mp2 uninstall.
		mp uninstall ]
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testWrapEssentialPrimitiveShouldBeCalledDuringInstallation [

	| mw method handler |
	method := SmallInteger >> #+.
	mw := RWIMethodProxy onMethod: method handler: (handler := RWICalledHandler new).
	self installMethodProxy: mw.

	self deny: handler called
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testWrapEssentialPrimitiveShouldNotRecurse [

	| mw method handler |
	method := SmallInteger >> #+.
	mw := RWIMethodProxy onMethod: method handler: (handler := RWICalledHandler new).
	self installMethodProxy: mw.

	"Do a perform, otherwise the addition is optimized out and tried as non-send addition.
	A message send is issued only if the normal addition fails"
	1 perform: #+ with: 2.

	self assert: handler called
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testWrapMethodCalledDuringInstallationIsNotIntercepted [

	| mw method handler |
	method := SmallInteger lookupSelector: #max:.
	mw := RWIMethodProxy onMethod: method handler: (handler := RWICalledHandler new).
	self installMethodProxy: mw.

	self deny: handler called
]

{ #category : 'tests - safety' }
RWIMethodProxyTest >> testWrapNonLocalReturns [

	| mp handler |
	mp := RWIMethodProxy
		      onMethod: RWIClassA >> #methodAcceptingABlock:
		      handler: (handler := RWIAfterCounterHandler new).

	self installMethodProxy: mp.

	RWIClassA new methodWithNonLocalReturn.

	self assert: handler count equals: 1
]

{ #category : 'tests' }
RWIMethodProxyTest >> testWrappingTwiceIsPossible [

	| mp1 method mp2 |
	[ 
	method := RWIClassA >> #methodOne.
	mp1 := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: self handlerClass new.
	mp1 install.

	mp2 := RWIMethodProxy on: #methodOne inClass: RWIClassA handler: RWIMockMethodProxyHandler new.
	mp2 install.

	self assert: mp1 selector equals: #methodOne.
	self assert: mp1 methodClass equals: RWIClassA.
	self assert: mp1 wrappedMethod equals: method.

	self assert: mp2 selector equals: #methodOne.
	self assert: mp2 methodClass equals: RWIClassA.
	self assert: mp2 wrappedMethod equals: mp1 ] ensure: [ 
		mp2 uninstall.
		self assert: (RWIClassA methodDict at: #methodOne) equals: mp1.
		mp1 uninstall.
		self assert: (RWIClassA methodDict at: #methodOne) equals: method ]
]
