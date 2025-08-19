Class {
	#name : 'BencherTest',
	#superclass : 'TestCase',
	#instVars : [
		'bencher'
	],
	#category : 'InstrumentationProfilers-Bench-New-Benchmarks',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'New-Benchmarks'
}

{ #category : 'running' }
BencherTest >> setUp [

    super setUp.

    bencher := Bencher new
]

{ #category : 'tests' }
BencherTest >> testFormatTime [

	self assert: (bencher formatTime: 60.5 milliSecond) equals: 60.5.
	self assert: (bencher formatTime: 60 milliSecond) equals: 60.
	self assert: (bencher formatTime: 4 seconds) equals: 4000.
	self assert: (bencher formatTime: (4 seconds + 33 milliSecond)) equals: 4033.
	self assert: (bencher formatTime: (1 minute + 4 seconds + 33 milliSecond)) equals: 64033.
	self assert: (bencher formatTime: (1 minute + 4.5 seconds + 33.5 milliSecond)) equals: 64533.5.
]
