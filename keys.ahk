;main:
	Suspend, On
	global isON := false
	global isWatingCopy := false
	global isCapslockDown := false
	global dMove := 150
	global dMoveSlow := 10
	global maxMode := 2
	global mode := 1
	global gmode := 1
	global gArrowType0 := null
	global gArrowType1 := null
	SetGUI()
	OnClipboardChange("ChangeEnterToSpace")
	return

GuiClose:
	ExitApp

MMove:
	stepSz := 0
	Loop
	{
		if GetKeyState("Shift", "P")
			stepSz := dMoveSlow
		else
			stepSz := dMove
			
		dx := dy := 0
		targetKey0 = left
		targetKey1 = right
		if (mode = 2)
		{
			targetKey0 = a
			targetKey1 = d
		}
		
		if GetKeyState(targetKey0, "P")
			dx := -++stepSz
		else if GetKeyState(targetKey1, "P")
			dx := ++stepSz
			
		targetKey0 = up
		targetKey1 = down
		if (mode = 2)
		{
			targetKey0 = w
			targetKey1 = s
		}
		
		if GetKeyState(targetKey0, "P")
			dy := -++stepSz
		else if GetKeyState(targetKey1, "P")
			dy := ++stepSz
			
		if (!dx and !dy)
			return
		else
			MouseMove, dx, dy,,R
	}
	return

InitializeGUI()
{
	GuiControl, , gArrowType0, 방향키(+ Shift) : 커서(+ 정밀)
	GuiControl, , gArrowType1, wasd : 휠
	GuiControl, , gmode, mode : %mode%
}

SetGUI()
{
	Gui, Add, Text, vgMode, mode : 1
	Gui, Add, Button, Default w220 gToggleWindow, ESC, CapsLock : Hide
	Gui, Add, Button, Default w220 gToggleAndCopyAndReplace, c : copy with enter to space
	Gui, Add, Button, Default w220 gToggleAndAV, v : Ctrl + (a, v)
	Gui, Add, Button, Default w220 gToggleAndUV, x : Ctrl + Alt + v
	Gui, Add, Button, Default w220 gToggleAndCapture, z : 캡쳐
	;Gui, Add, Button, Default w220 gToggleAndShbookmarks, x : 크롬 북마크
	Gui, Add, Button, Default w220 gToggleAndFind, f : Ctrl + (c, f, v)
	Gui, Add, Button, Default w220 gToggleAndInvert, r : 색반전
	Gui, Add, Button, Default w220 gToggleAndEnter, space : Enter
	Gui, Add, Text, vgArrowType0, FORMAXLENALLOCATIONFORMAXLENALLOCATION
	Gui, Add, Text, vgArrowType1, FORMAXLENALLOCATIONFORMAXLENALLOCATION
	Gui, Add, Text,, q, e : 클릭
	Gui, Add, Text,, b : 최소화
	Gui, Add, Text,, tab, 숫자 : 모드 전환
	Gui, +AlwaysOnTop
	InitializeGUI()
}

ToggleWindow()
{
	if (isON)
	{
		Suspend, On
		Gui, hide
	}
	else
	{
		Suspend, Off
		Gui, Show, w240 h380 X0 Y0
	}
	isON := !isON
	return
}

ChangeEnterToSpace()
{
	if !isWatingCopy
		return

	clipboard = %clipboard%`r`n
	StringReplace, clipboard, clipboard, `r`n, %A_Space%, All
	StringReplace, clipboard, clipboard, .%A_Space%, .`r`n`r`n, All
	isWatingCopy := false
	return
}

ChangeMode(n)
{
	mode := n
	GuiControl, , gmode, mode : %mode%
	
	if (mode = 1)
	{
		GuiControl, , gArrowType0, 방향키(+ Shift) : 커서(+ 정밀)
		GuiControl, , gArrowType1, wasd : 휠
	}
	else if (mode = 2)
	{
		GuiControl, , gArrowType0, 방향키 : 휠
		GuiControl, , gArrowType1, wasd(+ Shift) : 커서(+ 정밀)
	}
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

ToggleAndFind()
{
	ToggleWindow()
	sleep, 100
	Sendinput, ^c
	Sendinput, ^f
	Sendinput, ^v
	return
}

ToggleAndEnter()
{
	ToggleWindow()
	sleep, 100
	Sendinput, {enter}
	return
}

;---------------------------------------------------

Capslock::
	Suspend, Permit
	if (isCapslockDown = true)
		return
		
	isCapslockDown :=true
	ToggleWindow()
	return
	
esc::
	ToggleWindow()
	return
	
tab::
	m := mode
	if (m = maxMode)
		m := 0
		
	m := m+1
	ChangeMode(m)
	return

Capslock up::
	Suspend, Permit
	isCapslockDown :=false
	return

!,::
	Suspend, Permit
	CopyAndReplace()
	return

+^v::
	Suspend, Permit
	Sendinput, ^z
	Sendinput, ^a
	Sendinput, ^v
	return
	
c::
	ToggleAndCopyAndReplace()
	return
	
x::
	ToggleAndUV()
	return
	
z::
	ToggleAndCapture()
	return
	
;x::
;	ToggleAndShbookmarks()
;	return
	
r::
	ToggleAndInvert()
	return

v::
	ToggleAndAV()
	return

f::
	ToggleAndFind()
	return
	
space::
	ToggleAndEnter()
	return
	
b::
	Gui, Show, Minimize
	return
		
1::
	if (mode = 1)
		return
	
	ChangeMode(1)
	return
	
2::
	if (mode = 2)
		return
		
	ChangeMode(2)
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
	if (mode = 1)
		Sendinput, {Wheelup 1}
	else if (mode = 2)
		gosub MMove
	return
	
s::
	if (mode = 1)
		Sendinput, {WheelDown 1}
	else if (mode = 2)
		gosub MMove
	return
	
a::
	if (mode = 1)
		Sendinput, +{Wheelup 1}
	else if (mode = 2)
		gosub MMove
	return
	
d::
	if (mode = 1)
		Sendinput, +{WheelDown 1}
	else if (mode = 2)
		gosub MMove
	return

Up::
	if (mode = 1)
		gosub MMove
	else if (mode = 2)
		Sendinput, {Wheelup 1}
	return
	
Down::
	if (mode = 1)
		gosub MMove
	else if (mode = 2)
		Sendinput, {WheelDown 1}
	return
	
Left::
	if (mode = 1)
		gosub MMove
	else if (mode = 2)
		Sendinput, +{Wheelup 1}
	return
	
Right::
	if (mode = 1)
		gosub MMove
	else if (mode = 2)
		Sendinput, +{WheelDown 1}
	return
	
+w::
	if (mode = 2)
		gosub MMove
	return
	
+s::
	if (mode = 2)
		gosub MMove
	return
	
+a::
	if (mode = 2)
		gosub MMove
	return
	
+d::
	if (mode = 2)
		gosub MMove
	return

+Down::
	if (mode = 1)
		gosub MMove
	return
	
+Left::
	if (mode = 1)
		gosub MMove
	return
	
+Right::
	if (mode = 1)
		gosub MMove
	return
