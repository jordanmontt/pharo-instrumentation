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
			package: 'InstrumentationProfilers-Bench';
			package: 'InstrumentationProfilers' with: [ 
				spec requires: #( 'MethodProxies' 'MethodProxiesRunWithIn' ) ];
			package: 'InstrumentationProfilers-Tests' with: [ 
				spec requires: #( 'InstrumentationProfilers' ) ].

		spec
			baseline: 'MethodProxies'
			with: [ spec repository: 'github://pharo-contributions/MethodProxies/src' ].

		spec
			group: 'default' with: #( 'core' 'tests' );
			group: 'core' with: #( 'InstrumentationProfilers' 'InstrumentationProfilers-Bench' );
			group: 'tests' with: #( 'InstrumentationProfilers-Tests' ) ]
]
