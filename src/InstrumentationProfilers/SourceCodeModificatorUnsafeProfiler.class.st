Class {
	#name : 'SourceCodeModificatorUnsafeProfiler',
	#superclass : 'SourceCodeModificatorProfiler',
	#category : 'InstrumentationProfilers-Source code instrumentation',
	#package : 'InstrumentationProfilers',
	#tag : 'Source code instrumentation'
}

{ #category : 'profiling' }
SourceCodeModificatorUnsafeProfiler >> wrapBeforeActionFor: aMethod [

	^ beforeAction asString , ' cull: ' , aMethod nameForProfiler , '.'
]

{ #category : 'profiling' }
SourceCodeModificatorUnsafeProfiler >> wrapWithMetaSafeMechanism: aBlockAsString [

	^ aBlockAsString
]
