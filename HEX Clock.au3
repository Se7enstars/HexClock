#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Description=HexClock_F4
#AutoIt3Wrapper_Res_Fileversion=1.0.0.8
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Se7enstars
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;ConsoleWrite(_EncryptNum(@HOUR & @MIN & @SEC) & @LF)

#include <GUIConstants.au3>

Global $isTopmost = False
Global $uiColors[] = [0xDD0000, 0x00DD00, 0x0000DD, 0xDDDDDD, 0x111111]
Global $currentUIColor = 0
Global $iStartMenu = WinGetPos("[class:Shell_TrayWnd]")

$uiWidthPercent = 8
$ui_Width = ($uiWidthPercent*$iStartMenu[2])/100
$ui_Height = $iStartMenu[3]
$ui_XPos = 0
$ui_YPos = $iStartMenu[1]
$ui = GUICreate('Se7enstars HEX Time', $ui_Width, $ui_Height, $ui_XPos, $ui_YPos, $WS_POPUP, $WS_EX_TOOLWINDOW)
GUISetBkColor(0x0)

$time = GUICtrlCreateLabel(@HOUR&":"&@MIN, 0, 0, $ui_Width, $ui_Height, $SS_CENTERIMAGE+$SS_CENTER, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont(-1, 32, Default, Default, "Consolas", 5)
GUICtrlSetColor(-1, $uiColors[$currentUIColor])

$context = GUICtrlCreateContextMenu($time)
$topmostContext = GUICtrlCreateMenuItem("Top&most", $context)
$changeColorContext = GUICtrlCreateMenuItem("Change &Text Color", $context)
$changeBkColorContext = GUICtrlCreateMenuItem("&ChangeUI Color", $context)
$changeDefBkColorContext = GUICtrlCreateMenuItem("Change &Default UI Color", $context)
$exitContext = GUICtrlCreateMenuItem("&Exit", $context)

;UI_Init...
_changeDefBkColor()
_setTopmost()
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
			_setTopmost()
		Case $changeColorContext
			If $currentUIColor = UBound($uiColors)-1 Then
				$currentUIColor = 0
			Else
				$currentUIColor += 1
			EndIf
			GUICtrlSetColor($time, $uiColors[$currentUIColor])
		Case $changeBkColorContext
			AdlibRegister("_SetUIColor", 100)
		Case $changeDefBkColorContext
			_changeDefBkColor()
	EndSwitch
WEnd

Func _SetUIColor()
	Local $sColor
	If WinActive($ui) Then
		$mgp = MouseGetPos()
		$sColor = "0x" & Hex(PixelGetColor($mgp[0], $mgp[1]), 6)
		ToolTip($sColor)
		GUISetBkColor($sColor, $ui)
	Else
		ToolTip("")
		AdlibUnRegister("_SetUIColor")
		WinActivate($ui)
	EndIf
EndFunc

Func _UpdateTime()
	Local $getHexTime = _EncryptNum(@HOUR & "" & @MIN & "" & @SEC)
	GUICtrlSetData($time, $getHexTime)
	If $isTopmost = True Then 
		_setTopmost(1)
	EndIf
EndFunc

Func _EncryptNum($sString)
	Local $sEncryptedNums[] = ['X', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
	Local $sReturn = $sString
	For $i = 0 to 9
		$sReturn = StringReplace($sReturn, String($i), $sEncryptedNums[$i])
	Next
	Return $sReturn
EndFunc

Func _setTopmost($iForceTopmost = 0)
	If $iForceTopmost = 0 Then
		If $isTopmost Then
			GUICtrlSetState($topmostContext, 4)
			$isTopmost = False
			WinSetOnTop($ui, '', 0)		
		Else
			GUICtrlSetState($topmostContext, 1)
			$isTopmost = True
			WinSetOnTop($ui, '', 1)
		EndIf
	Else
		WinSetOnTop($ui, '', 1)
	EndIf
EndFunc

Func _changeDefBkColor()
	Local $aUICurrentPos = WinGetPos($ui)
	Local $x = $aUICurrentPos[0] + ($ui_Width/2)
	Local $y = $aUICurrentPos[1] + ($ui_Height/2)
	WinSetState($ui, '', @SW_HIDE)
	Local $sColor = "0x" & Hex(PixelGetColor($x, $y), 6)
	GUISetBkColor($sColor, $ui)
	WinSetState($ui, '', @SW_SHOW)
EndFunc