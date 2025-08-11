Extension { #name : 'BlockClosure' }

{ #category : '*MethodProxiesRunWithIn' }
BlockClosure >> methodProxyEnsure: aBlock [

	| handler complete returnValue |
	<primitive: 198>
	<methodProxyCannotWrap>
	"The handler should be in the first temporary to find it easily and support more complex unwind methods"
	handler := aBlock.
	returnValue := self valueNoContextSwitch.
	complete ifNil:[
		complete := true.
		aBlock value.
	].
	^ returnValue
]
