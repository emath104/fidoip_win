'/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
'   This file is part of fidoip. It is free software and it is covered
'   by the GNU general public license. See the file LICENSE for details. */

' Script for creation shortcut for ge.bat and rs.bat on Desktop  

' Called from setup_config.vbs configure script

On Error Resume Next 

Set Shell = CreateObject("wscript.shell")
DesktopPath = Shell.SpecialFolders("Desktop")
Set link = Shell.CreateShortCut(DesktopPath & "\ge.bat.lnk")
link.Arguments = ""
link.Description = "GoldEd FIDONet Editor"
link.Hotkey = "Ctrl+Alt+g"
link.IconLocation = "C:\usr\fidoconf\fidoip\fidoip-128.ico"
link.TargetPath = "C:\usr\bin\ge.bat" 
link.WindowStyle = 1
link.WorkingDirectory = "C:\usr\bin\"
link.Save

DesktopPath = Shell.SpecialFolders("Desktop")
Set link = Shell.CreateShortCut(DesktopPath & "\rs.bat.lnk")
link.Arguments = ""
link.Description = "Receive and Send FIDONet messages"
link.Hotkey = "Ctrl+Alt+r"
link.IconLocation = "C:\usr\fidoconf\fidoip\fidoip-64.ico"
link.TargetPath = "C:\usr\bin\rs.bat" 
link.WindowStyle = 1
link.WorkingDirectory = "C:\usr\bin\"
link.Save

