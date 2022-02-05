' Script created by Kirill Temnenkov 2:5020/828 for node 828
' Script modified by Maxim Sokolsky 2:5020/828 for fidoip package
Option Explicit


' Эти 8 констант нужно поправить!
'---------------------------------
const yourFullName      = "Vasiliy Pampasov"
const yourFTNAddress    = "2:5020/828.555"
const yourStationName   = "MyStation"
const yourLocation      = "Russia, Moscow"
const yourUplinkName    = "Kirill Temnenkov"
const uplinkFTNAddress  = "2:5020/828"
const uplinkServerName  = "temnenkov.dyndns.org"
const yourPassword      = "12345678"
'---------------------------------







Dim FSO

Set FSO = CreateObject("Scripting.FileSystemObject")

FSO.CopyFile "\usr\fidoconf\fidoip\binkd.cfg.template", "\usr\fidoconf\binkd.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\config.cfg.template", "\usr\fidoconf\config.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\golded.cfg.template", "\usr\GoldEd+\golded.cfg"
FSO.CopyFile "\usr\fidoconf\fidoip\names.fd.template", "\usr\GoldEd+\names.fd"
FSO.CopyFile "\usr\fidoconf\fidoip\params.bat.template", "\usr\bin\params.bat"
FSO.CopyFile "\usr\fidoconf\fidoip\rs.bat.template", "\usr\bin\rs.bat"

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
 ProcessFile fName, "Russia, Moscow", yourLocation
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
 ProcessDrive fName 
End Sub




Set FSO = CreateObject("Scripting.FileSystemObject")

ProcessAll "\usr\fidoconf\binkd.cfg"
ProcessAll "\usr\fidoconf\config.cfg"
ProcessAll "\usr\GoldEd+\golded.cfg"
ProcessAll "\usr\GoldEd+\names.fd"
ProcessAll "\usr\bin\params.bat" 
ProcessAll "\usr\bin\rs.bat"

Set FSO = nothing

msgbox "Настройка поинткомплекта завершена"