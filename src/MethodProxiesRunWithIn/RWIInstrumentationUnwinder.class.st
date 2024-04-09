Class {
	#name : 'RWIInstrumentationUnwinder',
	#superclass : 'InstrumentationEnsurer',
	#instVars : [
		'receiver',
		'arguments',
		'handler'
	],
	#category : 'MethodProxiesRunWithIn',
	#package : 'MethodProxiesRunWithIn'
}

{ #category : 'instance creation' }
RWIInstrumentationUnwinder class >> newWithHandler: aHandler receiver: receiver arguments: arguments [

	^ self new
		  handler: aHandler;
		  receiver: receiver;
		  arguments: arguments;
		  yourself
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> arguments [

	^ arguments
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> handler [

	^ handler
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> handler: anObject [

	handler := anObject
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> receiver [

	^ receiver
]

{ #category : 'accessing' }
RWIInstrumentationUnwinder >> receiver: anObject [

	receiver := anObject
]

{ #category : 'evaluating' }
RWIInstrumentationUnwinder >> value [

	<methodProxyCannotWrap>
	thisProcess runInMetaLevel: [
		^ handler aboutToReturnWithReceiver: receiver arguments: arguments ]
]
