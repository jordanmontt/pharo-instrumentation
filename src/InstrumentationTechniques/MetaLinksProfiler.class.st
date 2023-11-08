Class {
	#name : 'MetaLinksProfiler',
	#superclass : 'Object',
	#instVars : [
		'instrumentedMethods',
		'executedMethods',
		'metaLink'
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
	metaLink := MetaLink new
		metaObject: executedMethods;
		selector: #add:;
		arguments: #(method);
		yourself.
]

{ #category : 'adding' }
MetaLinksProfiler >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]

{ #category : 'adding' }
MetaLinksProfiler >> startProfiling [

	instrumentedMethods do: [ :method | method ast link: metaLink ]
]

{ #category : 'adding' }
MetaLinksProfiler >> stopProfiling [

	instrumentedMethods do: [ :method |
		method ast removeLink: metaLink.
		metaLink uninstall ]
]
