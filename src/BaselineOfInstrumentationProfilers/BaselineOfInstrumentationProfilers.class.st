Class {
	#name : 'BaselineOfInstrumentationProfilers',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfInstrumentationProfilers',
	#package : 'BaselineOfInstrumentationProfilers'
}

{ #category : 'baselines' }
BaselineOfInstrumentationProfilers >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'MethodProxiesRunWithIn';
			package: 'InstrumentationProfilers' with: [ spec requires: #( 'MethodProxies' 'MethodProxiesRunWithIn' ) ].

		spec
			baseline: 'MethodProxies'
			with: [ spec repository: 'github://pharo-contributions/MethodProxies/src' ].
		spec
			baseline: 'MethodProfiler'
			with: [ spec repository: 'github://jordanmontt/MethodProfiler:main' ].

		spec
			group: 'default' with: #( 'core' );
			group: 'core' with: #( 'InstrumentationProfilers' 'MethodProfiler' ) ]
]
