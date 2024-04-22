Class {
	#name : 'IPFileSystemBench',
	#superclass : 'IPAbstractBench',
	#category : 'InstrumentationProfilers-Bench',
	#package : 'InstrumentationProfilers-Bench'
}

{ #category : 'initialization' }
IPFileSystemBench >> packagesToInstrument [

	^ {
		  #'FileSystem-Core' asPackage.
		  #'FileSystem-Zip' asPackage.
		  #'FileSystem-Memory' asPackage.
		  #'FileSystem-Path' asPackage.
		  #'FileSystem-Disk' asPackage.
		  'Files' asPackage }
]

{ #category : 'initialization' }
IPFileSystemBench >> testPackages [

	^ {
		  #'FileSystem-Memory-Tests' asPackage.
		  #'FileSystem-Core-Tests' asPackage.
		  #'FileSystem-Disk-Tests' asPackage.
		  #'FileSystem-Tests-Attributes' asPackage.
		  'Files-Tests' asPackage }
]
