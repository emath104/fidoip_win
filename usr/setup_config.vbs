'/* Copyright (C) 2007-2012.
'   This file is part of fidoip. It is free software and it is covered
'   by the GNU general public license. See the file LICENSE for details. */

' Script was created by Kirill Temnenkov 2:5020/828 for node 828
' Script was modified by Falcony 2:5020/828.777 for fidoip package

' Script for creation FIDONet IP point configuraion
Option Explicit


' Эти 8 констант нужно поправить! You need change these 8 constants!
'---------------------------------
const yourFullName      = "Vasiliy Pampasov"
const yourFTNAddress    = "2:5020/828.555"
const yourStationName   = "MyStation"
const yourLocation      = "Moscow, Russia"
const yourUplinkName    = "Kirill Temnenkov"
const uplinkFTNAddress  = "2:5020/828"
const uplinkServerName  = "temnenkov.dyndns.org"
const yourPassword      = "12345678"
'---------------------------------



' Это необязательная настройка. This is additional setting.
' Поддержка FGHI в заголовках писем. FGHI support in headers.
' Yes или/or No.
'---------------------------------
const FGHIHeader       = "Yes"
'---------------------------------



















































Dim yourZoneNumber, yourFTNAddressTrim

yourFTNAddressTrim = Trim(yourFTNAddress)

yourZoneNumber  = Left(yourFTNAddressTrim,1)


Dim FSO

Set FSO = CreateObject("Scripting.FileSystemObject")

FSO.CopyFile "\usr\fidoconf\fidoip\binkd.cfg.template", "\usr\fidoconf\binkd.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\config.cfg.template", "\usr\fidoconf\config.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\golded.cfg.template", "\usr\GoldEd+\golded.cfg"
'FSO.CopyFile "\usr\fidoconf\fidoip\names.fd.template", "\usr\GoldEd+\names.fd"
FSO.CopyFile "\usr\fidoconf\fidoip\params.bat.template", "\usr\bin\params.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\rs.bat.template", "\usr\bin\rs.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\rs.bat.template", "\usr\bin\send.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\recv.bat.template", "\usr\bin\recv.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\welcome.bat.template", "\usr\bin\welcome.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\welcome.tpl.template", "\home\fido\welcome.tpl"
FSO.CopyFile "\usr\fidoconf\fidoip\shortcut.vbs.template", "\usr\bin\shortcut.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\crontask.vbs.template", "\usr\bin\crontask.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\crontab.cfg.template", "\usr\fidoconf\crontab.cfg"

If FGHIHeader = "Yes" Then
FSO.CopyFile "\usr\fidoconf\fidoip\golded.tpl.template","\usr\GoldEd+\golded.tpl"
else
FSO.CopyFile "\usr\fidoconf\fidoip\golded-fghi-disable.tpl.template", "\usr\GoldEd+\golded.tpl"
End If


Sub ProcessFile(ByVal fName, ByVal from_, ByVal to_)
 Const ForReading = 1, ForWriting = 2

 Dim rFile 
 Set rFile = FSO.OpenTextFile(fName,ForReading)
 Dim Text
 Text = rFile.ReadAll
 Text = replace(Text,from_,to_)

 Dim wFile 
 Set wFile = FSO.OpenTextFile(fName,ForWriting)
 wFile.Write Text

 Set rFile = nothing
 Set wFile = nothing
End Sub 

Sub ProcessName(ByVal fName)
 ProcessFile fName, "Vasiliy Pampasov", yourFullName
End Sub

Sub ProcessPoint(ByVal fName)
 ProcessFile fName, "2:5020/YYY.ZZZ", yourFTNAddress
End Sub

Sub ProcessStation(ByVal fName)
 ProcessFile fName, "MyStation", yourStationName
End Sub

Sub ProcessLocation(ByVal fName)
 ProcessFile fName, "Moscow, Russia", yourLocation
End Sub

Sub ProcessUpName(ByVal fName)
 ProcessFile fName, "Kirill Temnenkov", yourUplinkName
End Sub


Sub ProcessUpAddress(ByVal fName)
 ProcessFile fName, "2:5020/XXX", uplinkFTNAddress
End Sub


Sub ProcessUpServer(ByVal fName)
 ProcessFile fName, "temnenkov.dyndns.org", uplinkServerName
End Sub

Sub ProcessPass(ByVal fName)
 ProcessFile fName, "12345678", yourPassword
End Sub

Sub ProcessZone(ByVal fName)
 ProcessFile fName, "ZONE-NUMBER", yourZoneNumber
End Sub

Sub ProcessDrive(ByVal fName)
 ProcessFile fName, "%DRIVELETTER%", FSO.GetDriveName(FSO.GetAbsolutePathName(fName)) 
End Sub



Sub ProcessAll(ByVal fName)
 ProcessName fName 
 ProcessPoint fName
 ProcessStation fName
 ProcessLocation fName
 ProcessUpName fName
 ProcessUpAddress fName
 ProcessUpServer fName
 ProcessPass fName
 ProcessZone fName
 ProcessDrive fName 
End Sub




Set FSO = CreateObject("Scripting.FileSystemObject")

ProcessAll "\usr\fidoconf\binkd.cfg"
ProcessAll "\usr\fidoconf\config.cfg"
ProcessAll "\usr\GoldEd+\golded.cfg"
'ProcessAll "\usr\GoldEd+\names.fd"
ProcessAll "\usr\bin\params.bat" 
ProcessAll "\usr\bin\rs.bat"
ProcessAll "\usr\bin\recv.bat"
ProcessAll "\usr\bin\send.bat"
ProcessAll "\usr\bin\welcome.bat"
ProcessAll "\home\fido\welcome.tpl"
ProcessAll "\usr\bin\shortcut.vbs"
ProcessAll "\usr\bin\crontask.vbs"
ProcessAll "\usr\fidoconf\crontab.cfg"

Set FSO = nothing

Dim strProgramPath, objShell
strProgramPath = "cmd /c \usr\bin\welcome.bat"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath

WScript.Sleep(3000)

msgbox "Настройка поинткомплекта завершена/Setup of package for point is completed"

strProgramPath = "\usr\bin\shortcut.vbs"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath

WScript.Sleep(777)

msgbox "Прочите в редакторе Golded письмо с дальнейшими инструкциями/Read message to you in GoldED"

WScript.Sleep(777)

strProgramPath = "cmd /c \usr\bin\ge.bat"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath


