Class {
	#name : 'AbstractPrfMethodIntercepter',
	#superclass : 'MpHandler',
	#instVars : [
		'proxy',
		'method',
		'runner'
	],
	#category : 'MethodProfiler-runWitnIn',
	#package : 'MethodProfiler',
	#tag : 'runWitnIn'
}

{ #category : 'instance creation' }
AbstractPrfMethodIntercepter class >> newForMethod: aMethod withRunner: aRunner [

	^ self new
		  method: aMethod;
		  runner: aRunner;
		  yourself
]

{ #category : 'evaluating' }
AbstractPrfMethodIntercepter >> afterMethod [

	runner exitMethod: method
]

{ #category : 'evaluating' }
AbstractPrfMethodIntercepter >> beforeMethod [

	runner enterMethod: method
]

{ #category : 'installation' }
AbstractPrfMethodIntercepter >> install [

	proxy ifNil: [
		proxy := self methodProxyClass onMethod: method handler: self.
		proxy install ]
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> method [

	^ method
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> method: anObject [

	method := anObject
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> methodProxyClass [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> proxy [

	^ proxy
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> runner [

	^ runner
]

{ #category : 'accessing' }
AbstractPrfMethodIntercepter >> runner: anObject [

	runner := anObject
]

{ #category : 'installation' }
AbstractPrfMethodIntercepter >> uninstall [

	proxy ifNotNil: [
		proxy uninstall.
		proxy := nil ]
]
