#RequireAdmin
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

Global $hKey, $sKeyPath, $sValueName, $sValue

$sKeyPath = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$sValueName = "Shell"

;Read current value of the registry key
$sValue=RegRead($sKeyPath, $sValueName)

;Create a GUI to allow the user to change the value
$gui = GUICreate("Change Shell", 400, 100)
GUICtrlCreateLabel("Current Value: " & $sValue, 10, 10)
GUICtrlCreateLabel("New Value: ", 10, 30)
$input = GUICtrlCreateInput($sValue, 100, 30, 200)
$button = GUICtrlCreateButton("Change Value", 50, 60, 100, 30)
GUICtrlSetOnEvent($button, "ChangeValue")
$cancelButton = GUICtrlCreateButton("Cancel", 250, 60, 100, 30)
GUICtrlSetOnEvent($cancelButton, "ExitProgram")
GUISetState()

; function to change the value of the registry key
Func ChangeValue()
    $sNewValue = GUICtrlRead($input)
    RegWrite($sKeyPath, $sValueName, "REG_SZ", $sNewValue)
    MsgBox(48, "" "Shell changed! Current Shell is now: " & $sNewValue & ". Please save your work now, cause you will be logged off.")
	Shutdown(0)
EndFunc


Func ExitProgram()
    Exit
EndFunc

; main loop of the GUI
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitProgram()
    EndSwitch
WEnd
