Class {
	#name : 'IPUninsFileSystemBench',
	#superclass : 'IPUninsAbstractBench',
	#category : 'InstrumentationProfilers-Bench-Uninstrumentation',
	#package : 'InstrumentationProfilers-Bench',
	#tag : 'Uninstrumentation'
}

{ #category : 'initialization' }
IPUninsFileSystemBench >> packagesToInstrument [

	^ {
		  #'FileSystem-Core' asPackage.
		  #'FileSystem-Zip' asPackage.
		  #'FileSystem-Memory' asPackage.
		  #'FileSystem-Path' asPackage.
		  #'FileSystem-Disk' asPackage.
		  'Files' asPackage }
]

{ #category : 'initialization' }
IPUninsFileSystemBench >> testPackages [

	^ {
		  #'FileSystem-Memory-Tests' asPackage.
		  #'FileSystem-Core-Tests' asPackage.
		  #'FileSystem-Disk-Tests' asPackage.
		  #'FileSystem-Tests-Attributes' asPackage.
		  'Files-Tests' asPackage }
]
