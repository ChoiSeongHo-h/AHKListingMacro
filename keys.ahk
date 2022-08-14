;main:
	OnClipboardChange("ChangeEnterToSpace")
	global isON := true
	global isWaingCopy := false
	dMove = 150
	dMoveSlow = 10
	Gui, Add, Text,, CapsLock : Hide
	Gui, Add, Text,, c : copy with replacing enter to space
	Gui, Add, Text,, v : Ctrl + a -> Ctrl + v
	Gui, Add, Text,, x : Ctrl + Alt + v
	Gui, Add, Text,, s : 캡쳐
	Gui, Add, Text,, d : 크롬 북마크
	Gui, Add, Text,, f : 색반전
	Gui, Add, Text,, Ctrl + Alt + 방향키 : 커서 움직임
	Gui, Add, Text,, Ctrl + Alt + Shift + 방향키 : 느린 커서 움직임
	Gui, Add, Text,, Ctrl + Alt + z : 좌클릭
	Gui, Add, Text,, Ctrl + Alt + Shift + Alt + z : 우클릭
	return

GuiClose:
	ExitApp
	
ToggleWindow()
{
	if isON
		Gui, hide
	else
		Gui, Show, w300 h300
	isON := !isON
	return
}

ChangeEnterToSpace()
{
	if !isWaingCopy
		return

	StringReplace, clipboard, clipboard, `r`n, %A_Space%, All
	isWaingCopy := false
	return
}

Capslock::
	ToggleWindow()
	return

~c::
	if !isON
		return
		
	ToggleWindow()
	Sendinput, ^c
	isWaingCopy := true
	
	return
	
~x::
	if !isON
		return
		
	ToggleWindow()
	Sendinput, ^!v
	return
	
~s::
	if !isON
		return
		
	ToggleWindow()
	Sendinput, +#s
	return
	
~d::
	if !isON
		return
		
	ToggleWindow()
	sleep, 100
	Sendinput, ^+b
	return
	
~f::
	if !isON
		return
		
	ToggleWindow()
	sleep, 100
	Sendinput, #^c
	return

~v::
	if !isON
		return
		
	ToggleWindow()
	sleep, 100
	Sendinput, ^a
	sleep, 50
	Sendinput, ^v
	return
	
~^!Up::
	if !isON
		return
		
	MouseMove, 0, (dMove * -1), 0, R
	return
	
~^!Down::
	if !isON
		return
		
	MouseMove, 0, dMove, 0, R
	return
	
~^!Left::
	if !isON
		return
		
	MouseMove, (dMove * -1), 0, 0, R
	return
	
~^!Right::
	if !isON
		return
		
	MouseMove, dMove, 0, 0, R
	return
	
~^!z::
	if !isON
		return
		
	Click, left
	return
	
~^!+z::
	if !isON
		return
		
	Click, right
	return
	
~^!+Up::
	if !isON
		return
		
	MouseMove, 0, (dMoveSlow * -1), 0, R
	return
	
~^!+Down::
	if !isON
		return
		
	MouseMove, 0, dMoveSlow, 0, R
	return
	
~^!+Left::
	if !isON
		return
		
	MouseMove, (dMoveSlow * -1), 0, 0, R
	return
	
~^!+Right::
	if !isON
		return
		
	MouseMove, dMoveSlow, 0, 0, R
	return
	