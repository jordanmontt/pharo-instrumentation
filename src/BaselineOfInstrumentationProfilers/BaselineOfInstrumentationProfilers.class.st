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
			package: 'MethodProfiler' with: [ spec requires: #( 'MethodProxies' 'MethodProxiesRunWithIn' ) ];
			package: 'InstrumentationProfilers' with: [ spec requires: #( 'MethodProxies' 'MethodProxiesRunWithIn' 'MethodProfiler' ) ].

		spec
			baseline: 'MethodProxies'
			with: [ spec repository: 'github://pharo-contributions/MethodProxies/src' ].

		spec
			group: 'default' with: #( 'core' );
			group: 'core' with: #( 'InstrumentationProfilers' ) ]
]
