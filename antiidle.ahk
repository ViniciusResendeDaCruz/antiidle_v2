#Requires AutoHotkey v2.0
#SingleInstance Force

; Path to the INI file
configFile := A_ScriptDir . "\config.ini"

; Load configurations or set default values
global antiIdleInterval := IniRead(configFile, "Settings", "AntiIdleInterval", 2000)
global antiIdleMoveAmount := IniRead(configFile, "Settings", "AntiIdleMoveAmount", 1)

antiSleepVal := IniRead(configFile, "Settings", "AntiSleepVal", 0)
antiIdleVal := IniRead(configFile, "Settings", "AntiIdleVal", 0)
antiAFKVal := IniRead(configFile, "Settings", "AntiAFKVal", 0)

; Create the main GUI
mGui := Gui()
mGui.Opt("Resize")

; Create the menu bar and menus
mMenuBar := MenuBar()
mFileMenu := Menu()

; Add items to the File menu
mFileMenu.Add("Mouse Settings", (*) => OpenMouseConfig())
mFileMenu.Add("Exit (Ctrl+Shift+Esc)", (*) => ExitApp())

; Add the File menu to the menu bar
mMenuBar.Add("File", mFileMenu)

; Assign the menu bar to the GUI
mGui.MenuBar := mMenuBar

; Add controls to the GUI
displayActiveCtrl := mGui.Add("Checkbox", "vAntiSleepVal", "Keep display active")
antiIdleCtrl := mGui.Add("Checkbox", "vAntiIdleVal", "Move mouse")
antiAfkCtrl := mGui.Add("Checkbox", "vAntiAFKVal", "Press modifier keys")
startCtrl := mGui.Add("Button", "y+10 w50", "Start")
stopCtrl := mGui.Add("Button", "x+10 w50", "Stop")
statusCtrl := mGui.Add("Text", "x+10 yp+5 Hidden vStatus", "Anti Idle ON")

; Set initial values for the checkboxes
displayActiveCtrl.Value := antiSleepVal
antiIdleCtrl.Value := antiIdleVal
antiAfkCtrl.Value := antiAFKVal

; Assign event handlers to buttons
startCtrl.OnEvent("Click", ButtonStart)
stopCtrl.OnEvent("Click", ButtonStop)

; Show the GUI
mGui.Show()

; Function to handle the "Start" button click
ButtonStart(*) {
    global antiIdleCtrl, displayActiveCtrl, antiAfkCtrl, statusCtrl, antiIdleInterval

    ; Start timers based on selected options
    if (antiIdleCtrl.Value > 0) {
        SetTimer AntiIdle, antiIdleInterval
    }
    if (displayActiveCtrl.Value > 0) {
        SetTimer AntiSleep, 120000
    }
    if (antiAfkCtrl.Value > 0) {
        SetTimer AntiAFK, 5000
    }
    if (antiIdleCtrl.Value > 0 || displayActiveCtrl.Value > 0 || antiAfkCtrl.Value > 0) {
        statusCtrl.Visible := true
    }

    ; Save the state of the checkboxes
    SaveCheckBoxValues()
}

; Function to handle the "Stop" button click
ButtonStop(*) {
    global statusCtrl

    ; Hide the status text and stop all timers
    statusCtrl.Visible := false
    SetTimer AntiIdle, 0
    SetTimer AntiSleep, 0
    SetTimer AntiAFK, 0

    ; Save the state of the checkboxes
    SaveCheckBoxValues()
}

; Function to save the checkbox values to the INI file
SaveCheckBoxValues() {
    IniWrite displayActiveCtrl.Value, configFile, "Settings", "AntiSleepVal"
    IniWrite antiIdleCtrl.Value, configFile, "Settings", "AntiIdleVal"
    IniWrite antiAfkCtrl.Value, configFile, "Settings", "AntiAFKVal"
}

; Function that opens the mouse settings configuration GUI
OpenMouseConfig(*) {
    global antiIdleInterval, antiIdleMoveAmount

    ; Create the configuration GUI
    configGui := Gui("+AlwaysOnTop")
    configGui.Add("Text", "x10 y10", "Mouse Move Interval (ms):")
    intervalEdit := configGui.Add("Edit", "x150 y10 w100", antiIdleInterval)
    configGui.Add("Text", "x10 y40", "Mouse Move Amount (pixels):")
    amountEdit := configGui.Add("Edit", "x150 y40 w100", antiIdleMoveAmount)
    saveButton := configGui.Add("Button", "x10 y70 w80", "Save")
    cancelButton := configGui.Add("Button", "x100 y70 w80", "Cancel")

    ; Assign event handlers for the Save and Cancel buttons
    saveButton.OnEvent("Click", (*) => saveButton_Click(intervalEdit, amountEdit, configGui))
    cancelButton.OnEvent("Click", (*) => configGui.Destroy())

    ; Show the configuration GUI
    configGui.Show()
    configGui.Opt("-AlwaysOnTop")
}

; Function to handle the "Save" button click in the configuration GUI
saveButton_Click(intervalEdit, amountEdit, configGui) {
    global antiIdleInterval, antiIdleMoveAmount, configFile

    ; Get the values from the edit fields
    newInterval := intervalEdit.Value
    newAmount := amountEdit.Value

    ; Validate and assign the new values
    if (IsInteger(newInterval) && newInterval > 0) {
        antiIdleInterval := newInterval
        IniWrite antiIdleInterval, configFile, "Settings", "AntiIdleInterval"
    } else {
        MsgBox("Please enter a valid interval.")
        return
    }

    if (IsInteger(newAmount) && newAmount > 0) {
        antiIdleMoveAmount := newAmount
        IniWrite antiIdleMoveAmount, configFile, "Settings", "AntiIdleMoveAmount"
    } else {
        MsgBox("Please enter a valid move amount.")
        return
    }

    ; Close the configuration GUI
    configGui.Destroy()
}

; Function to move the mouse based on the current configurations
AntiIdle() {
    global antiIdleMoveAmount
    MouseMove 0, antiIdleMoveAmount, 0, "R"
    Sleep 1000
    MouseMove 0, -antiIdleMoveAmount, 0, "R"
}

; Function to keep the display active
AntiSleep() {
    DllCall("SetThreadExecutionState", "UInt", 0x80000003)
}

; Function to press modifier keys to prevent AFK detection
AntiAFK() {
    Send "{Shift}"
    Send "{Ctrl}"
}

; Hotkey to exit the script (Ctrl+Shift+Esc)
^+Esc:: ExitApp()
