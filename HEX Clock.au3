#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Description=HexClock
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Se7enstars
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;ConsoleWrite(_EncryptNum(@HOUR & @MIN & @SEC) & @LF)

Global $isTopmost = false

$ui = GUICreate('Se7enstars HEX Time', 300, 70, Default, Default, 0x80880000, 0x00000080)
GUISetBkColor(0x0)

$time = GUICtrlCreateLabel("LOADING", 0, -15, 300, 100, 0x01+0x0200, 0x00100000); CENTER, DRAG_MODE
GUICtrlSetFont(-1, 48, Default, Default, "Consolas")
GUICtrlSetColor(-1, 0x00DD00)

$context = GUICtrlCreateContextMenu($time)
$topmostContext = GUICtrlCreateMenuItem("&Topmost", $context)
$exitContext = GUICtrlCreateMenuItem("&Exit", $context)

GUISetState()

AdlibRegister("_UpdateTime", 1000)

While  1
	Sleep(20)
	$msg = GUIGetMsg()
	Switch $msg
		Case -3
			Exit
		Case $exitContext
			Exit
		Case $topmostContext
			If $isTopmost Then
				GUICtrlSetState($topmostContext, 4)
				$isTopmost = False
				WinSetOnTop($ui, '', 0)
				
			Else
				GUICtrlSetState($topmostContext, 1)
				$isTopmost = True
				WinSetOnTop($ui, '', 1)
			EndIf
	EndSwitch
WEnd

Func _UpdateTime()
	Local $getHexTime = _EncryptNum(@HOUR & " " & @MIN & " " & @SEC)
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