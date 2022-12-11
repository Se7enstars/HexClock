
;ConsoleWrite(_EncryptNum(@HOUR & @MIN & @SEC) & @LF)
#NoTrayIcon
$ui = GUICreate('Se7enstars HEX Time', 300, 100)

$time = GUICtrlCreateLabel("XX:XX:XX", 0, 0, 300, 100, 0x01+0x0200, 0x00100000); CENTER, DRAG_MODE
GUICtrlSetFont(-1, 48, Default, Default, "Cambria")

GUISetState()

AdlibRegister("_UpdateTime", 1000)

While  1
	Sleep(20)
	If GUIGetMsg() = -3 Then Exit
WEnd

Func _UpdateTime()
	Local $getHexTime = _EncryptNum(@HOUR & ":" & @MIN & ":" & @SEC)
	GUICtrlSetData($time, $getHexTime)
EndFunc

Func _EncryptNum($sString)
	Local $sEncryptedNums[] = ['X', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
	Local $sReturn = $sString
	For $i = 0 to 9
		$sReturn = StringReplace($sReturn, String($i), $sEncryptedNums[$i])
	Next
	Return $sReturn
EndFunc