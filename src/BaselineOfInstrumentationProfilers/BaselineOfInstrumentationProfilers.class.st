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
			package: 'InstrumentationProfilers' with: [ spec requires: #('MethodProxiesRunWithIn') ];
			package: 'InstrumentationProfilers-Bench' with: [ spec requires: #('InstrumentationProfilers') ];
			package: 'MethodProxiesRunWithIn-Tests' with: [ spec requires:  'MethodProxiesRunWithIn' ];
			package: 'InstrumentationProfilers-Tests' with: [ spec requires: #( 'InstrumentationProfilers' ) ].

		spec
			baseline: 'MethodProxies'
			with: [ spec repository: 'github://pharo-contributions/MethodProxies/src' ].
		spec
			baseline: 'MethodCallGraph'
			with: [ spec repository: 'github://jordanmontt/MethodCallGraph:main' ].
		spec
			baseline: 'IllimaniProfiler'
			with: [ spec repository: 'github://jordanmontt/illimani-memory-profiler:dev' ].
		spec baseline: 'VeritasBenchSuite' with: [ spec repository: 'github://jordanmontt/PharoVeritasBenchSuite:main' ].
		spec
			package: 'InstrumentationProfilers' with: [ 
				spec requires: #( 'IllimaniProfiler' 'MethodProxies' 'MethodCallGraph' 'MethodProxiesRunWithIn' 'VeritasBenchSuite') ].

		spec
			group: 'default' with: #( 'core' 'tests' );
			group: 'core' with: #( 'InstrumentationProfilers' 'InstrumentationProfilers-Bench' );
			group: 'tests' with: #( 'InstrumentationProfilers-Tests' 'MethodProxiesRunWithIn-Tests' ) ]
]
