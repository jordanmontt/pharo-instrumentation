Class {
	#name : 'IPInsFileSystemBench',
	#superclass : 'IPInsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Instrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Instrumentation'
}

{ #category : 'initialization' }
IPInsFileSystemBench >> packagesToInstrument [

	^ {
		  #'FileSystem-Core' asPackage.
		  #'FileSystem-Zip' asPackage.
		  #'FileSystem-Memory' asPackage.
		  #'FileSystem-Path' asPackage.
		  #'FileSystem-Disk' asPackage.
		  'Files' asPackage }
]

{ #category : 'initialization' }
IPInsFileSystemBench >> testPackages [

	^ {
		  #'FileSystem-Memory-Tests' asPackage.
		  #'FileSystem-Core-Tests' asPackage.
		  #'FileSystem-Disk-Tests' asPackage.
		  #'FileSystem-Tests-Attributes' asPackage.
		  'Files-Tests' asPackage }
]
