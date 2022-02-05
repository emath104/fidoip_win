@echo off
call \usr\bin\params.bat
echo Scanning for inbound messages and files and packing
\usr\bin\hpt.exe scan pack
echo Tossing messages
\usr\bin\htick.exe toss
echo Annoncing received files
\usr\bin\htick.exe announce
echo Linking received messages into echo areas
\usr\bin\hpt.exe toss link
echo AreaFix changing requests processing
\usr\bin\hpt.exe afix
echo FileFix changing requests processing
\usr\bin\htick.exe ffix
echo New fecho files tossing
\usr\bin\htick.exe toss
