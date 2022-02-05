@echo off
call params.bat
\usr\bin\hpt.exe scan pack
\usr\bin\binkd.exe -cp -P2:5020/828 \usr\fidoconf\binkd.cfg
\usr\bin\htick.exe toss
\usr\bin\htick.exe announce
\usr\bin\hpt.exe toss link