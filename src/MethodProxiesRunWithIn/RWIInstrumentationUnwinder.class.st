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

{ #category : 'converting' }
RWIInstrumentationUnwinder >> asContextWithSender: aContext [
	"Inner private support method for evaluation.  Do not use unless you know what you're doing."

	^(Context newForMethod: (RWIInstrumentationUnwinder >> #value))
		setSender: aContext
		receiver: self
		method: (RWIInstrumentationUnwinder >> #value)
		closure: nil
		startpc: (RWIInstrumentationUnwinder >> #value) initialPC;
		privRefresh
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
	'unwind' traceCr.
	Processor activeProcess runInMetaLevel: [
		handler aboutToReturnWithReceiver: receiver arguments: arguments ]
]
