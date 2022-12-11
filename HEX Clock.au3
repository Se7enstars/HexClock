
ConsoleWrite(_EncryptNum(@HOUR & @MIN & @SEC) & @LF)

Func _EncryptNum($sString)
	Local $sEncryptedNums[] = ['X', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
	Local $sReturn = $sString
	For $i = 0 to 9
		$sReturn = StringReplace($sReturn, String($i), $sEncryptedNums[$i])
	Next
	Return $sReturn
EndFunc