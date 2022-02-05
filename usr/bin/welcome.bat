echo off

set FIDOCONFIG=C:\usr\fidoconf\config.cfg
C:

echo Generating welcome message

\usr\bin\txt2pkt.exe -nf "Developer of fidoip" -xf 2:5020/828.555  -xt 2:5020/828.555 -nt "Vasiliy Pampasov" -t "Powered by fidoip package" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Welcome, new point!" -e "welcome.fido" -d \home\fido\localinb \home\fido\welcome.tpl
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

