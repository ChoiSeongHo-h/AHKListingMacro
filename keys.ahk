;main:
	OnClipboardChange("ChangeEnterToSpace")
	global isON := true
	global isWaingCopy := false
	dMove = 150
	dMoveSlow = 10
	Gui, Add, Button, Default w280 gToggleWindow, CapsLock : Hide
	Gui, Add, Button, Default w280 gToggleAndCopyAndReplace, c : copy with replacing enter to space
	Gui, Add, Button, Default w280 gToggleAndAV, v : Ctrl + a -> Ctrl + v
	Gui, Add, Button, Default w280 gToggleAndX, x : Ctrl + Alt + v
	Gui, Add, Button, Default w280 gToggleAndCapture, s : 캡쳐
	Gui, Add, Button, Default w280 gToggleAndShbookmarks, d : 크롬 북마크
	Gui, Add, Button, Default w280 gToggleAndInvert, f : 색반전
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
		Gui, Show, w300 h320
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

CopyAndReplace()
{
	Sendinput, ^c
	isWaingCopy := true
	return
}

ToggleAndCopyAndReplace()
{
	ToggleWindow()
	CopyAndReplace()
	return
}

ToggleAndAV()
{
	ToggleWindow()
	sleep, 100
	Sendinput, ^a
	sleep, 50
	Sendinput, ^v
	return
}

ToggleAndX()
{
	ToggleWindow()
	Sendinput, ^!v
	return
}

ToggleAndCapture()
{
	ToggleWindow()
	Sendinput, +#s
	return
}

ToggleAndInvert()
{
	ToggleWindow()
	sleep, 100
	Sendinput, #^c
	return
}

ToggleAndShbookmarks()
{
	ToggleWindow()
	sleep, 100
	Sendinput, ^+b
	return
}

Capslock::
	ToggleWindow()
	return

~c::
	if !isON
		return
	
	ToggleAndCopyAndReplace()
	return
	
!,::
	CopyAndReplace()
	return
	
~x::
	if !isON
		return
		
	ToggleAndX()
	return
	
~s::
	if !isON
		return
		
	ToggleAndCapture()
	return
	
~d::
	if !isON
		return
		
	ToggleAndShbookmarks()
	return
	
~f::
	if !isON
		return
		
	ToggleAndInvert()
	return

~v::
	if !isON
		return
		
	ToggleAndAV()
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
	
