Class {
	#name : 'MetaLinksDumbProfiler',
	#superclass : 'Object',
	#instVars : [
		'beforeMetaLink',
		'afterMetaLink',
		'originalMethods'
	],
	#category : 'InstrumentationProfilers-MetaLink',
	#package : 'InstrumentationProfilers',
	#tag : 'MetaLink'
}

{ #category : 'adding' }
MetaLinksDumbProfiler >> addMethods: methodsCollection [

	originalMethods addAll: methodsCollection
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> enterMethod: aMethod [

	('enterMethod:' , aMethod name) traceCr
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> exitMethod: aMethod [

	('exitMethod:' , aMethod name) traceCr
]

{ #category : 'initialization' }
MetaLinksDumbProfiler >> initialize [

	super initialize.
	originalMethods := Set new.

	beforeMetaLink := MetaLink new
		metaObject: self;
		selector: #enterMethod:;
		arguments: #(method);
		control: #before;
		optionCompileOnLinkInstallation: true;
		yourself.
	afterMetaLink := MetaLink new
		metaObject: self;
		selector: #exitMethod:;
		arguments: #(method);
		control: #after;
		optionCompileOnLinkInstallation: true;
		yourself.
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> profile: aBlock [

	self startProfiling.
	aBlock ensure: [ self stopProfiling ]
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> startProfiling [

	originalMethods do: [ :method |
		method ast
			link: beforeMetaLink;
			link: afterMetaLink ]
]

{ #category : 'adding' }
MetaLinksDumbProfiler >> stopProfiling [

	originalMethods do: [ :method |
		method ast
			removeLink: beforeMetaLink;
			removeLink: afterMetaLink.
		beforeMetaLink uninstall.
		afterMetaLink uninstall ]
]
