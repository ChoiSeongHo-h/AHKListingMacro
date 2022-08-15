;main:
	Suspend, On
	OnClipboardChange("ChangeEnterToSpace")
	global isON := false
	global isWatingCopy := false
	dMove = 150
	dMoveSlow = 10
	Gui, Add, Button, Default w280 gToggleWindow, CapsLock : Hide
	Gui, Add, Button, Default w280 gToggleAndCopyAndReplace, c : copy with replacing enter to space
	Gui, Add, Button, Default w280 gToggleAndAV, v : Ctrl + a -> Ctrl + v
	Gui, Add, Button, Default w280 gToggleAndUV, f : Ctrl + Alt + v
	Gui, Add, Button, Default w280 gToggleAndCapture, z : 캡쳐
	Gui, Add, Button, Default w280 gToggleAndShbookmarks, x : 크롬 북마크
	Gui, Add, Button, Default w280 gToggleAndInvert, r : 색반전
	Gui, Add, Text,, 방향키 : 커서 움직임
	Gui, Add, Text,, Shift + 방향키 : 느린 커서 움직임
	Gui, Add, Text,, q, e : 클릭
	Gui, Add, Text,, w, a, s, d : 휠
	Gui, +AlwaysOnTop +ToolWindow
	return

GuiClose:
	ExitApp
	
ToggleWindow()
{
	if isON
	{
		Suspend, On
		Gui, hide
	}
	else
	{
		Suspend, Off
		Gui, Show, w300 h310
	}
	isON := !isON
	return
}

ChangeEnterToSpace()
{
	if !isWatingCopy
		return

	StringReplace, clipboard, clipboard, `r`n, %A_Space%, All
	isWatingCopy := false
	return
}

CopyAndReplace()
{
	isWatingCopy := true
	Sendinput, ^c
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

ToggleAndUV()
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

	
MMove:
	dstepSz := 0
	Loop
	{
		if GetKeyState("Shift", "P")
			dstepSz := dMoveSlow
		else
			dstepSz := dMove
			
		dx := dy := 0
		if GetKeyState("left", "P")
			dx := -++dstepSz
		else if GetKeyState("right", "P")
			dx := ++dstepSz
		if GetKeyState("up", "P")
			dy := -++dstepSz
		else if GetKeyState("down", "P")
			dy := ++dstepSz
		if (!dx and !dy)
			return
		else
			MouseMove, dx, dy,,R
	}
	return

;---------------------------------------------------

Capslock::
	Suspend, Permit
	ToggleWindow()
	return

c::
	ToggleAndCopyAndReplace()
	return
	
!,::
	Suspend, Permit
	CopyAndReplace()
	return
	
f::
	ToggleAndUV()
	return
	
z::
	ToggleAndCapture()
	return
	
x::
	ToggleAndShbookmarks()
	return
	
r::
	ToggleAndInvert()
	return

v::
	ToggleAndAV()
	return

;--------------------------------------------------------------

q::
	GetKeyState, state, LButton
	if (state = "D")
		return
		
	Click, down left
	return
	
q up::
	Click, up left
	return
	
e::
	GetKeyState, state, RButton
	if (state = "D")
		return
		
	Click, down right
	return
	
e up::
	Click, up right
	return	
	
w::
	Sendinput, {Wheelup 1}
	return
	
s::
	Sendinput, {WheelDown 1}
	return
	
a::
	Sendinput, +{Wheelup 1}
	return
	
d::
	Sendinput, +{WheelDown 1}
	return

Up::
	gosub MMove
	return
	
Down::
	gosub MMove
	return
	
Left::
	gosub MMove
	return
	
Right::
	gosub MMove
	return
	
+Up::
	gosub MMove
	return
	
+Down::
	gosub MMove
	return
	
+Left::
	gosub MMove
	return
	
+Right::
	gosub MMove
	return
