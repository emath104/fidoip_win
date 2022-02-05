echo off
IF EXIST \home\fido\config.win (findstr "EchoArea" \home\fido\config.win >> \usr\fidoconf\config.cfg ) ELSE echo windows's fidoip temporary area list is missing. Trasfer area list manually.
