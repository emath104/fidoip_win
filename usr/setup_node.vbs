'/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
'   This file is part of fidoip. It is free software and it is covered
'   by the GNU general public license. See the file LICENSE for details. */

' Script for creation FIDONet IP node configuraion

Option Explicit


' Эти 10 констант нужно поправить! You need change these 10 constants!
'---------------------------------
const yourFullName                = "Vasiliy Pampasov"
const yourNodeAddress             = "2:5020/788"
const yourStationName             = "MyStation"
const yourLocation                = "Moscow, Russia"
const yourDNSNAMEorIP             = "192.168.4.7"
const your1stPointPassword        = "12345678"

const yourUplinkName              = "Kirill Temnenkov"
const uplinkFTNAddress            = "2:5020/828"
const uplinkServerName            = "temnenkov.dyndns.org"
const yourUplinkPassword          = "09876543"
'---------------------------------



' Это необязательная настройка. This is additional setting.
' Поддержка FGHI в заголовках писем. FGHI support in headers.
' Yes или/or No.
'---------------------------------
const FGHIHeader       = "Yes"
'----------------------------















































Dim yourZoneNumber, yourFTNAddressTrim, yourFTNAddressLen, yourShorNodeNameLen, yourShorNodeName
yourFTNAddressTrim = Trim(yourNodeAddress)
yourZoneNumber  = Left(yourFTNAddressTrim,1)
yourFTNAddressLen = Len(yourFTNAddressTrim)
yourShorNodeNameLen = yourFTNAddressLen - 2
yourShorNodeName = Right(yourFTNAddressTrim,yourShorNodeNameLen) 
yourShorNodeName = Replace(yourShorNodeName, "/", "-")


Dim uplinkFTNAddressTrim, uplinkFTNAddressLen, uplinkShorNodeNameLen, uplinkShorNodeName
uplinkFTNAddressTrim = Trim(uplinkFTNAddress)
uplinkFTNAddressLen = Len(uplinkFTNAddressTrim)
uplinkShorNodeNameLen = uplinkFTNAddressLen - 2
uplinkShorNodeName = Right(uplinkFTNAddressTrim,uplinkShorNodeNameLen) 
uplinkShorNodeName = Replace(uplinkShorNodeName, "/", "-")


Dim FSO

Set FSO = CreateObject("Scripting.FileSystemObject")

FSO.CopyFile "\usr\fidoconf\fidoip\node\binkd.cfg.template-node", "\usr\fidoconf\binkd.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\node\config.template-node", "\usr\fidoconf\config.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\node\decode.txt.template-node", "\usr\GoldEd+\golded.cfg"
'FSO.CopyFile "\usr\fidoconf\fidoip\names.fd.template", "\usr\GoldEd+\names.fd"
FSO.CopyFile "\usr\fidoconf\fidoip\params.bat.template", "\usr\bin\params.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\rs.bat.template", "\usr\bin\rs.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\readonly-link.lst.template-node", "\usr\fidoconf\readonly.lst"
FSO.CopyFile "\usr\fidoconf\fidoip\node\uplink.lst.template-node", "\usr\fidoconf\uplink.lst"
FSO.CopyFile "\usr\fidoconf\fidoip\node\link.lst", "\usr\fidoconf\link.lst"
FSO.CopyFile "\usr\fidoconf\fidoip\node\point.lst", "\usr\fidoconf\point.lst"
FSO.CopyFile "\usr\fidoconf\fidoip\node\routing.lst", "\usr\fidoconf\routing.lst"
FSO.CopyFile "\usr\fidoconf\fidoip\node\route-default.lst.template-node", "\usr\fidoconf\route-default.lst"

FSO.CopyFile "\usr\fidoconf\fidoip\node\areafix.template-node", "\home\fido\areafix.hlp"
FSO.CopyFile "\usr\fidoconf\fidoip\node\filefix.template-node", "\home\fido\filefix.hlp"

FSO.CopyFile "\usr\fidoconf\fidoip\node\macro.cfg.template-node",  "\usr\GoldEd+\macro.cfg"

FSO.CopyFile "\usr\fidoconf\fidoip\node\fido.dayly.bat.template-node",  "\usr\bin\fido.dayly.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\fido.monthly.bat.template-node",  "\usr\bin\fido.monthly.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\rules.txt",  "\home\fido\rules.txt"
FSO.CopyFile "\usr\fidoconf\fidoip\node\rules1.txt",  "\home\fido\rules1.txt"
FSO.CopyFile "\usr\fidoconf\fidoip\node\rules2.txt",  "\home\fido\rules2.txt"

FSO.CopyFile "\usr\fidoconf\fidoip\node\binkdsrv.bat.template-node",  "\usr\bin\binkdsrv.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\recv.bat.template-node",  "\usr\bin\recv.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\rs.bat.template-node",  "\usr\bin\rs.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\poll.bat.template-node",  "\usr\bin\poll.bat"

FSO.CopyFile "\usr\fidoconf\fidoip\node\clean_outb.vbs.template-node",  "\usr\bin\clean_outb.vbs"

FSO.CopyFile "\usr\fidoconf\fidoip\node\welcome.bat.template-node",  "\usr\bin\welcome.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\node\welcome2.template-node",  "\home\fido\welcome2.template-node"
FSO.CopyFile "\usr\fidoconf\fidoip\node\announce1.template-node",  "\home\fido\announce1.template-node"
FSO.CopyFile "\usr\fidoconf\fidoip\node\announce.template-node",  "\home\fido\announce.template-node"
FSO.CopyFile "\usr\fidoconf\fidoip\node\crontask.vbs.template-node", "\usr\bin\crontask.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\crontab.cfg.template-node", "\usr\fidoconf\crontab.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\node\shortcut.vbs.template-node", "\usr\bin\shortcut.vbs"

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
 ProcessFile fName, "SYSTEM-OPERATOR-NAME", yourFullName
End Sub

Sub ProcessPointName(ByVal fName)
 ProcessFile fName, "POINT-NAME", yourFullName
End Sub

Sub ProcessPointNumber(ByVal fName)
 ProcessFile fName, "POINT-NUMBER", "1"
End Sub

Sub ProcessNode1(ByVal fName)
 ProcessFile fName, "MYNODE-ADDRESS", yourNodeAddress
End Sub

Sub ProcessStation(ByVal fName)
 ProcessFile fName, "SYSTEM-NAME", yourStationName
End Sub

Sub ProcessLocation(ByVal fName)
 ProcessFile fName, "LOCATION-TOWN", yourLocation
End Sub

Sub ProcessUpName1(ByVal fName)
 ProcessFile fName, "FIRSTLINK-NODE-NAME", yourUplinkName
End Sub

Sub ProcessUpName(ByVal fName)
 ProcessFile fName, "LINK-NODE-NAME", yourUplinkName
End Sub

	
Sub ProcessUpAddress1(ByVal fName)
 ProcessFile fName, "FIRSTLINK-NODE-ADDRESS", uplinkFTNAddress
End Sub

Sub ProcessUpRead(ByVal fName)
 ProcessFile fName, " LINK-ADDRESS", uplinkFTNAddress
End Sub

Sub ProcessUpAddress(ByVal fName)
 ProcessFile fName, "LINK-NODE-ADDRESS", uplinkFTNAddress
End Sub

Sub ProcessUpServer1(ByVal fName)
 ProcessFile fName, "FIRSTLINK-HOST-DOMAIN-NAME", uplinkServerName
End Sub	

Sub ProcessUpServer(ByVal fName)
 ProcessFile fName, "LINK-HOST-DOMAIN-NAME", uplinkServerName
End Sub	

Sub ProcessmyDNSNAMEorIP(ByVal fName)
 ProcessFile fName, "MYHOST-DOMAIN-NAME", yourDNSNAMEorIP
End Sub	


Sub ProcessPass1(ByVal fName)
 ProcessFile fName, "FIRSTLINK-NODE-PASSWORD", yourUplinkPassword
End Sub

Sub ProcessPass(ByVal fName)
 ProcessFile fName, "LINK-NODE-PASSWORD", yourUplinkPassword
End Sub

Sub ProcessZone(ByVal fName)
 ProcessFile fName, "ZONE-NUMBER", yourZoneNumber
End Sub

Sub ProcessShortNodeAddress(ByVal fName)
 ProcessFile fName, "SHORTNODE-NAME", yourShorNodeName
End Sub

Sub ProcessShortUplinkAddress(ByVal fName)
 ProcessFile fName, "SHORTLINK-NAME", uplinkShorNodeName
End Sub


Sub ProcessPass1st(ByVal fName)
 ProcessFile fName, "MYPOINT-PASSWORD", your1stPointPassword
End Sub


Sub ProcessDrive(ByVal fName)
 ProcessFile fName, "%DRIVELETTER%", FSO.GetDriveName(FSO.GetAbsolutePathName(fName)) 
End Sub



Sub ProcessAll(ByVal fName)
 ProcessName fName 
 ProcessNode1 fName
 ProcessStation fName
 ProcessLocation fName
 ProcessUpName1 fName
 ProcessUpName fName
 ProcessUpAddress1 fName
 ProcessUpAddress fName
 ProcessUpServer1 fName
 ProcessUpServer fName
 ProcessPass1 fName
 ProcessPass fName
 ProcessZone fName
 ProcessmyDNSNAMEorIP fName
 ProcessPass1st fName
 ProcessUpRead fName
 ProcessShortNodeAddress fName
 ProcessShortUplinkAddress fName
 ProcessPointNumber fName
 ProcessPointName fName
 ProcessDrive fName 
End Sub




Set FSO = CreateObject("Scripting.FileSystemObject")

ProcessAll "\usr\fidoconf\binkd.cfg"
ProcessAll "\usr\fidoconf\config.cfg"
ProcessAll "\usr\GoldEd+\golded.cfg"
'ProcessAll "\usr\GoldEd+\names.fd"
ProcessAll "\usr\bin\params.bat" 
ProcessAll "\usr\bin\rs.bat"

ProcessAll "\usr\fidoconf\readonly.lst"
ProcessAll "\usr\fidoconf\uplink.lst"
ProcessAll "\usr\fidoconf\link.lst"
ProcessAll "\usr\fidoconf\point.lst"
ProcessAll "\usr\fidoconf\routing.lst" 
ProcessAll "\usr\fidoconf\route-default.lst"

ProcessAll "\usr\bin\binkdsrv.bat"

ProcessAll "\usr\GoldEd+\macro.cfg"

ProcessAll "\usr\bin\fido.dayly.bat"

ProcessAll "\usr\bin\fido.monthly.bat"

ProcessAll "\home\fido\rules.txt"
ProcessAll "\home\fido\rules1.txt"
ProcessAll "\home\fido\rules2.txt"

ProcessAll  "\home\fido\areafix.hlp"
ProcessAll  "\home\fido\filefix.hlp"

ProcessAll "\usr\bin\clean_outb.vbs"

ProcessAll "\usr\bin\poll.bat"

ProcessAll "\usr\bin\welcome.bat"

ProcessAll "\home\fido\welcome2.template-node"

ProcessAll "\home\fido\announce1.template-node"

ProcessAll "\home\fido\announce.template-node"

ProcessAll "\usr\bin\shortcut.vbs"

ProcessAll  "\usr\bin\crontask.vbs"

ProcessAll  "\usr\fidoconf\crontab.cfg"


Set FSO = nothing


Dim objFolder

Set FSO = CreateObject("Scripting.FileSystemObject")

If FSO.FolderExists("\usr\tools") Then
Set objFolder = FSO.GetFolder("\usr\tools")
Else
Set objFolder = FSO.CreateFolder("\usr\tools")
End If

FSO.CopyFile "\usr\fidoconf\fidoip\node\addpoint.vbs.template-node",  "\usr\tools\addpoint.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\addlink.vbs.template-node",  "\usr\tools\addlink.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\addread.vbs.template-node",  "\usr\tools\addread.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\listlink.vbs.template-node",  "\usr\tools\listlink.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\listpoint.vbs.template-node",  "\usr\tools\listpoint.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\removelink.vbs.template-node",  "\usr\tools\removelink.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\removepoint.vbs.template-node",  "\usr\tools\removepoint.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\listecho.vbs.template-node",  "\usr\tools\listecho.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\listread.vbs.template-node",  "\usr\tools\listread.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\removeread.vbs.template-node",  "\usr\tools\removeread.vbs"
FSO.CopyFile "\usr\fidoconf\fidoip\node\pointlist.vbs.template-node",  "\usr\tools\pointlist.vbs"


Dim fName1 

Sub ProcessFileUpdate(ByVal fName1, ByVal from_, ByVal to_)
 Const ForReading = 1, ForWriting = 2

 Dim rFile 
 Set rFile = FSO.OpenTextFile(fName1,ForReading)
 Dim Text
 Text = rFile.ReadAll
 Text = replace(Text,from_,to_)

 Dim wFile 
 Set wFile = FSO.OpenTextFile(fName1,ForWriting)
 wFile.Write Text

 Set rFile = nothing
 Set wFile = nothing
End Sub 




Sub MyFullName(ByVal fName1)
 ProcessFileUpdate fName1, "Vasiliy Pampasov", yourFullName
End Sub

Sub FTNAddress(ByVal fName1)
 ProcessFileUpdate fName1, "2:5020/788", yourNodeAddress
End Sub

Sub MySysName(ByVal fName1)
 ProcessFileUpdate fName1, "MyStation", yourStationName
End Sub

Sub ShorNodeName(ByVal fName1)
 ProcessFileUpdate fName1, "5020-788", yourShorNodeName
End Sub



Sub ProcessUpdate(ByVal fName1)
 MyFullName fName1 
 FTNAddress fName1
 MySysName fName1
 ShorNodeName fName1
End Sub


ProcessUpdate "\usr\tools\addpoint.vbs"
ProcessUpdate "\usr\tools\addlink.vbs"
ProcessUpdate "\usr\tools\addread.vbs"
ProcessUpdate  "\usr\tools\removelink.vbs"
ProcessUpdate  "\usr\tools\removepoint.vbs"
ProcessUpdate  "\usr\tools\removeread.vbs"


Dim strProgramPath, objShell
strProgramPath = "cmd /c \usr\bin\welcome.bat"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath

strProgramPath = "\usr\bin\shortcut.vbs"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath


msgbox "Производим тестовый запуск сервиса binkd и планировщика заданий fxcron" &VbCrLf& "Now we are testing binkd service and fxcron daemon " 

WScript.Sleep(3000)

strProgramPath = "cmd /c \usr\bin\binkdsrv.bat"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath

WScript.Sleep(3000)

msgbox "Настройка узлового комплекта завершена" &VbCrLf& "Setup of package for node is completed"  &VbCrLf&  "Для управления используйте fidoip Node Management Tools в каталоге \usr\tools"  &VbCrLf&  "For management use Node Management Tools in \usr\tools"

WScript.Sleep(777)

msgbox "Прочите в редакторе Golded письмо с дальнейшими инструкциями/Read message to you in GoldED"

WScript.Sleep(777)

strProgramPath = "cmd /c \usr\bin\ge.bat"
set objShell = createobject("Wscript.Shell")
objShell.Run strProgramPath

