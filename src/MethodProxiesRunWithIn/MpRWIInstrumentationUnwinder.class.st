Class {
	#name : 'MpRWIInstrumentationUnwinder',
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
MpRWIInstrumentationUnwinder class >> newWithHandler: aHandler receiver: receiver arguments: arguments [

	^ self new
		  handler: aHandler;
		  receiver: receiver;
		  arguments: arguments;
		  yourself
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> arguments [

	^ arguments
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> arguments: anObject [

	arguments := anObject
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> handler [

	^ handler
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> handler: anObject [

	handler := anObject
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> receiver [

	^ receiver
]

{ #category : 'accessing' }
MpRWIInstrumentationUnwinder >> receiver: anObject [

	receiver := anObject
]

{ #category : 'evaluating' }
MpRWIInstrumentationUnwinder >> value [

	<methodProxyCannotWrap>
	thisProcess runInMetaLevel: [
		^ handler aboutToReturnWithReceiver: receiver arguments: arguments ]
]
