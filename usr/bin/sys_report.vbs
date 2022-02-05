'/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
'   This file is part of fidoip. It is free software and it is covered
'   by the GNU general public license. See the file LICENSE for details. */

' Statistics script 
' It gather system statistics of node and save it to file \home\fido\system-dayly.tmp
' then fidoip.dayly.bat script put it to local echo .robots of node


On Error Resume Next

Set oShell = CreateObject("wscript.Shell")
Set env = oShell.environment("Process")
strComputer = env.Item("Computername")
Const HKEY_LOCAL_MACHINE = &H80000002
Const UnInstPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"

Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_
".\root\default:StdRegProv")


report = strComputer & " runs node on:" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem",,48)

report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "OS Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
For Each objItem in colItems
    report = report &  "Caption: " & objItem.Caption & vbCrLf
    report = report &  "Description: " & objItem.Description & vbCrLf
    report = report &  "EncryptionLevel: " & objItem.EncryptionLevel & vbCrLf
    report = report &  "InstallDate: " & objItem.InstallDate & vbCrLf
    report = report &  "Manufacturer: " & objItem.Manufacturer & vbCrLf
    report = report &  "MaxNumberOfProcesses: " & objItem.MaxNumberOfProcesses & vbCrLf
    report = report &  "Name: " & objItem.Name & vbCrLf
    report = report &  "Organization: " & objItem.Organization & vbCrLf
    report = report &  "OSProductSuite: " & objItem.OSProductSuite & vbCrLf
    report = report &  "RegisteredUser: " & objItem.RegisteredUser & vbCrLf
    report = report &  "SerialNumber: " & objItem.SerialNumber & vbCrLf
    report = report &  "ServicePackMajorVersion: " & objItem.ServicePackMajorVersion
    report = report &  "ServicePackMinorVersion: " & objItem.ServicePackMinorVersion & vbCrLf
    report = report &  "Version: " & objItem.Version & vbCrLf
    report = report &  "WindowsDirectory: " & objItem.WindowsDirectory & vbCrLf

Next

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colSMBIOS = objWMIService.ExecQuery ("Select * from Win32_SystemEnclosure")
For Each objSMBIOS in colSMBIOS
    report = report &  "DellserviceTag: "  & objSMBIOS.SerialNumber & vbCrLf

next

'Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
'Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=True")
'For Each objItem in colItems
'    report = report &  "Mac Address: "  & objItem.MACAddress & vbCrLf
'Next


Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery ("Select * from Win32_NetworkAdapter")
For Each objItem in colItems
report = report &  "Mac Address: "  & objItem.MACAddress & vbCRLf
Next



Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery _
    ("Select * from Win32_NetworkAdapterConfiguration")

For Each objItem in colItems
    For Each strIPAddress in objItem.IPAddress

If strIPAddress = "" Then
     report = report &  "IP Address: " & "No IP setted" & vbCrLf
Else
     report = report &  "IP Address: " & strIPAddress & vbCrLf
End If
    Next
Next




Set colSettings = objWMIService.ExecQuery _
    ("Select * from Win32_ComputerSystem")
report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Memory and Processor Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
For Each objComputer in colSettings
'report = report & objComputer.Name & vbcrlf
report = report & objComputer.TotalPhysicalMemory /1024\1024+1 & "MB Total memory" & vbcrlf
Next

Set colItems = GetObject("WinMgmts:root/cimv2").ExecQuery("Select * FROM Win32_PerfFormattedData_PerfOS_Memory ")
For Each objItem In colItems   
 strLinePercentCommittedBytesInUse = strLinePercentCommittedBytesInUse & " " & objItem.PercentCommittedBytesInUse

' Wscript.Echo "test: " & strLinePercentCommittedBytesInUse

report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Memory Utilization:" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
report = report & strLinePercentCommittedBytesInUse &  "% persents of RAM used" & vbcrlf
report = report & vbCrLf & "******************************************" & vbCrLf
Next 

Set colSettings = objWMIService.ExecQuery _
    ("Select * from Win32_Processor")
For Each objProcessor in colSettings
report = report & objProcessor.Description & " Processor" & vbCrLf
Next


Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PerfFormattedData_PerfOS_Processor WHERE Name = '_Total'")
For Each objItem In colItems   
 strLineProcessorTime = strLineProcessorTime & " " & objItem.PercentProcessorTime
report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Processor Utilization:" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
report = report & strLineProcessorTime  &  "% persents of CPU used" & vbcrlf
report = report & vbCrLf & "******************************************" & vbCrLf
Next 


'Gets FREE SPACE Report
Set oDrives = objFSO.Drives
For Each oDrive In oDrives
 Select Case oDrive.DriveType
  Case 2 'Fixed Drives    
   strLineDriveSpace = strLineDriveSpace & " " & oDrive.DriveLetter & "\: " & Round(oDrive.FreeSpace / (1024 * 1024)) & "MB free (" & Round(100 * (oDrive.FreeSpace / oDrive.TotalSize), 2) & " %) "
report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Disk C: Drive Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
report = report & strLineDriveSpace & vbCrLf   
 End Select
Next 

report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Disk C: Drive Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf

Set objWMIService = GetObject("winmgmts:")
Set objLogicalDisk = objWMIService.Get("Win32_LogicalDisk.DeviceID='c:'")
report = report & objLogicalDisk.FreeSpace /1024\1024+1 & "MB Free Disk Space" & vbCrLf
report = report & objLogicalDisk.Size /1024\1024+1 & "MB Total Disk Space" & vbCrLf


report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Disk D: Drive Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf

Set objWMIService = GetObject("winmgmts:")
Set objLogicalDisk = objWMIService.Get("Win32_LogicalDisk.DeviceID='d:'")
report = report & objLogicalDisk.FreeSpace /1024\1024+1 & "MB Free Disk Space" & vbCrLf
report = report & objLogicalDisk.Size /1024\1024+1 & "MB Total Disk Space" & vbCrLf


report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Disk E: Drive Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf

Set objWMIService = GetObject("winmgmts:")
Set objLogicalDisk = objWMIService.Get("Win32_LogicalDisk.DeviceID='e:'")
report = report & objLogicalDisk.FreeSpace /1024\1024+1 & "MB Free Disk Space" & vbCrLf
report = report & objLogicalDisk.Size /1024\1024+1 & "MB Total Disk Space" & vbCrLf


report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Disk F: Drive Information" & vbCrLf & "******************************************" & vbCrLf & vbCrLf

Set objWMIService = GetObject("winmgmts:")
Set objLogicalDisk = objWMIService.Get("Win32_LogicalDisk.DeviceID='F:'")
report = report & objLogicalDisk.FreeSpace /1024\1024+1 & "MB Free Disk Space" & vbCrLf
report = report & objLogicalDisk.Size /1024\1024+1 & "MB Total Disk Space" & vbCrLf


oReg.EnumKey HKEY_LOCAL_MACHINE, UnInstPath, arrSubKeys
software = software & vbCrLf & "******************************************" & vbCrLf
software = software & "Installed Software" & vbCrLf & "******************************************" & vbCrLf & vbCrLf
For Each subkey In arrSubKeys
'MsgBox subkey
If Left (subkey, 1) <> "{" Then
    software = software & subkey & vbCrLf
End If
Next

'report = report & vbCrLf & "******************************************" & vbCrLf
'report = report & "Virus status report" & vbCrLf
'report = report & vbCrLf & "******************************************" & vbCrLf

'Set objWMIService = GetObject("winmgmts:" _
'    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
'Set colLoggedEvents = objWMIService.ExecQuery _
'        ("Select * from Win32_NTLogEvent Where Logfile = 'System' and " _
'            & "EventCode = '1116'")
'Set colDeletedLoggedEvents = objWMIService.ExecQuery _
'        ("Select * from Win32_NTLogEvent Where Logfile = 'System' and " _
'            & "EventCode = '1117'")

'report = report & "Microsoft Avtimailware virus warnings: " & colLoggedEvents.Count & vbCrLf
'report = report & "Microsoft Avtimailware virus cured: " & colDeletedLoggedEvents.Count & vbCrLf



report = report & vbCrLf & "******************************************" & vbCrLf
report = report & "Service runs and could be stopped" & vbCrLf
report = report & vbCrLf & "******************************************" & vbCrLf


Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colServices = objWMIService.ExecQuery _
    ("Select * from Win32_Service Where AcceptStop= True")

For Each objService in colServices
report = report &   objService.DisplayName & vbCrLf
Next


report = report & vbCrLf & "******************************************" & vbCrLf
report = report &  "Runned processes from users" & vbCrLf
report = report & vbCrLf & "******************************************" & vbCrLf


Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process")

For Each objProcess in colProcessList
    colProperties = objProcess.GetOwner(strNameOfUser,strUserDomain)
report = report &  "Process " & objProcess.Name & " is owned by " _ 
        & strUserDomain & "\" & strNameOfUser & "." & vbCrLf
Next

report = report & vbCrLf & "******************************************" & vbCrLf
report = report &  "Connected Printers" & vbCrLf
report = report & vbCrLf & "******************************************" & vbCrLf

Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    report = report &  "Name: " & objPrinter.Name & vbCrLf
    report = report &  "Location: " & objPrinter.Location & vbCrLf
    Select Case objPrinter.PrinterStatus
        Case 1
            strPrinterStatus = "Other"
        Case 2
            strPrinterStatus = "Unknown"
        Case 3
            strPrinterStatus = "Idle"
        Case 4
            strPrinterStatus = "Printing"
        Case 5
            strPrinterStatus = "Warmup"
    End Select
    report = report &  "Printer Status: " & strPrinterStatus & vbCrLf
    report = report &  "Server Name: " & objPrinter.ServerName & vbCrLf
    report = report &  "Share Name: " & objPrinter.ShareName & vbCrLf
    report = report & vbCrLf
Next



report = report & vbCrLf & "******************************************" & vbCrLf
report = report &  "Network shares" & vbCrLf
report = report & vbCrLf & "******************************************" & vbCrLf

Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colShares = objWMIService.ExecQuery("Select * from Win32_Share")

For each objShare in colShares
    report = report & "Allow Maximum: " & objShare.AllowMaximum  & vbCrLf 
    report = report & "Caption: " & objShare.Caption   & vbCrLf
    report = report & "Maximum Allowed: " & objShare.MaximumAllowed & vbCrLf
    report = report & "Name: " & objShare.Name    & vbCrLf
    report = report & "Path: " & objShare.Path   & vbCrLf
    report = report & "Type: " & objShare.Type   & vbCrLf
    report = report  & vbCrLf
Next
	

Set fso = CreateObject("Scripting.FileSystemObject")
Set ts = fso.CreateTextFile ("\home\fido\system-dayly.tmp", ForWriting)
ts.write report
ts.write software