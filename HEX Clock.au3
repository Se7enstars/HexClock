#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Description=HexClock_F4
#AutoIt3Wrapper_Res_Fileversion=1.0.0.6
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Se7enstars
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;ConsoleWrite(_EncryptNum(@HOUR & @MIN & @SEC) & @LF)

#Include <WindowsConstants.au3>

Global $isTopmost = false
Global $uiColors[] = [0xDD0000, 0x00DD00, 0x0000DD]
Global $currentUIColor = 1

$ui_w = 240
$ui = GUICreate('Se7enstars HEX Time', $ui_w, 70, Default, Default, $WS_POPUP, $WS_EX_TOOLWINDOW)
GUISetBkColor(0x0)

$time = GUICtrlCreateLabel("Int://", 0, -15, $ui_w, 100, 0x01+0x0200, 0x00100000); CENTER, DRAG_MODE
GUICtrlSetFont(-1, 48, Default, Default, "Consolas", 5)
GUICtrlSetColor(-1, $uiColors[$currentUIColor])

$context = GUICtrlCreateContextMenu($time)
$topmostContext = GUICtrlCreateMenuItem("&Topmost", $context)
$changeColorContext = GUICtrlCreateMenuItem("&ChangeUI", $context)

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
		Case $changeColorContext
			If $currentUIColor = UBound($uiColors)-1 Then
				$currentUIColor = 0
			Else
				$currentUIColor += 1
			EndIf
			GUICtrlSetColor($time, $uiColors[$currentUIColor])
	EndSwitch
WEnd

Func _UpdateTime()
	Local $getHexTime = _EncryptNum(@HOUR & "" & @MIN & "" & @SEC)
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