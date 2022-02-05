'/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
'   This file is part of fidoip. It is free software and it is covered
'   by the GNU general public license. See the file LICENSE for details. */


' Script for starting fidoip Task Manager fxcron 

On Error Resume Next 

Const strComputer = "." 
Dim objWMIService, colProcessList
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'fxcron.exe'")
For Each objProcess in colProcessList 
objProcess.Terminate() 
Next


DIM objShell
set objShell=wscript.createObject("wscript.shell")
iReturn=objShell.Run("C:\usr\bin\fxcron.exe -f C:\usr\fidoconf\crontab.cfg -l C:\home\fido\crond.log -v", 0, TRUE)