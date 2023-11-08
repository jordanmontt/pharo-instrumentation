Class {
	#name : 'MetaLinksProfiler',
	#superclass : 'Object',
	#instVars : [
		'instrumentedMethods',
		'executedMethods',
		'beforeMetaLink'
	],
	#category : 'InstrumentationTechniques-MetaLink',
	#package : 'InstrumentationTechniques',
	#tag : 'MetaLink'
}

{ #category : 'adding' }
MetaLinksProfiler >> addMethod: aMethod [

	instrumentedMethods add: aMethod
]

{ #category : 'adding' }
MetaLinksProfiler >> addMethods: methodsCollection [

	methodsCollection do: [ :method | self addMethod: method ]
]

{ #category : 'initialization' }
MetaLinksProfiler >> initialize [

	super initialize.
	instrumentedMethods := Set new.
	executedMethods := Set new.
	beforeMetaLink := MetaLink new
		metaObject: executedMethods;
		selector: #add:;
		arguments: #(method);
		control: #before;
		yourself.
]

{ #category : 'adding' }
MetaLinksProfiler >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]

{ #category : 'adding' }
MetaLinksProfiler >> startProfiling [

	instrumentedMethods do: [ :method | method ast link: beforeMetaLink ]
]

{ #category : 'adding' }
MetaLinksProfiler >> stopProfiling [

	instrumentedMethods do: [ :method |
		method ast removeLink: beforeMetaLink.
		beforeMetaLink uninstall ]
]
