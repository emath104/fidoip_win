@echo off
call params.bat
\usr\bin\hpt.exe scan
\usr\bin\hpt.exe pack
\usr\bin\binkd.exe -cp -P2:5020/828 \usr\fidoconf\binkd.cfg
\usr\bin\hpt.exe toss
\usr\bin\htick.exe toss
\usr\bin\htick.exe announce
\usr\bin\sqpack.exe *
\usr\bin\hpt.exe link *