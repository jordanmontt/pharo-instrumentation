Class {
	#name : 'IPExeFileSystemBench',
	#superclass : 'IPExeAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Execute',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Execute'
}

{ #category : 'initialization' }
IPExeFileSystemBench >> packagesToInstrument [

	^ {
		  #'FileSystem-Core' asPackage.
		  #'FileSystem-Zip' asPackage.
		  #'FileSystem-Memory' asPackage.
		  #'FileSystem-Path' asPackage.
		  #'FileSystem-Disk' asPackage.
		  'Files' asPackage }
]

{ #category : 'initialization' }
IPExeFileSystemBench >> testPackages [

	^ {
		  #'FileSystem-Memory-Tests' asPackage.
		  #'FileSystem-Core-Tests' asPackage.
		  #'FileSystem-Disk-Tests' asPackage.
		  #'FileSystem-Tests-Attributes' asPackage.
		  'Files-Tests' asPackage }
]
