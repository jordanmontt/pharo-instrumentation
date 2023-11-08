Extension { #name : 'CompiledMethod' }

{ #category : '*MethodProxiesRunWithIn' }
CompiledMethod >> install [
	"does not nothing. Act as a NullObject for MethodProxy."
	^ self
]

{ #category : '*MethodProxiesRunWithIn' }
CompiledMethod >> isMethodProxy [

	^ false
]

{ #category : '*MethodProxiesRunWithIn' }
CompiledMethod >> uninstall [
	"does not nothing. Act as a NullObject for MethodProxy."
	^ self
]

{ #category : '*MethodProxiesRunWithIn' }
CompiledMethod >> unproxifiedMethod [
	^ self 
]
