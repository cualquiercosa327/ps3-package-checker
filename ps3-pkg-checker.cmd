@echo off


:reset
:: Change terminal size
mode con lines=40


set scriptVersion=0.2
set titleText=PS3 Package Checker v%scriptVersion%                      esc0rtd3w 2017

title %titleText%


color 0e

set waitTime=3
set wait=ping -n %waitTime% 127.0.0.1

set root=%cd%
set binPath=%root%\bin
set dumpPath=%root%\dump

set updateListComplete="%root%\dump\updateListComplete.txt"
set updateListActive="%root%\dump\updateListActive.txt"
set updateListFail="%root%\dump\updateListFail.txt"

set cocolor="%binPath%\cocolor.exe"
set wget="%binPath%\wget.exe"
set xml="%binPath%\xml.exe"

set titleID=XXXX00000
set titleIDRegionCode=XXXX
set titleIDRegionDisc=BXXX
set titleIDRegionPSN=NPXX
set titleIDNumber=00000
set titleIDNumberStart=0
set titleIDNumberMin=00000
set titleIDNumberMax=99999
set isRegion=0
set padding=0

set isBlankXML=0

set prefixURL=https://
set serverA=%prefixURL%a0.ww.np.dl.playstation.net/tpl/np/%titleID%/%titleID%-ver.xml
set serverB=%prefixURL%b0.ww.np.dl.playstation.net/tppkg/np/%titleID%/%titleID%-ver.xml
set userAgent=--user-agent="Mozilla/5.0 (PLAYSTATION 3; 4.81)"
set disableCertCheck=--no-check-certificate

set isLoop=0
set return=start


:start
title %titleText%
set titleChoice=99

cls
echo Choose an option and press ENTER:
echo.
echo.
%cocolor% 0a
echo 1) Check/Dump All Possible Title IDs
echo.
%cocolor% 0b
echo 2) Check/Dump All PSN Title IDs
echo 3) Check/Dump All Disc Title IDs
echo.
%cocolor% 05
echo 4) Check/Dump All JAPAN Title IDs [BCJS]
echo 5) Check/Dump All JAPAN Title IDs [BLJM]
echo 6) Check/Dump All JAPAN Title IDs [NPJB]
echo 7) Check/Dump All JAPAN Title IDs [BLJS]
echo 8) Check/Dump All JAPAN Title IDs [NPJA]
echo.
%cocolor% 09
echo 9) Check/Dump All USA Title IDs [BCUS]
echo 10) Check/Dump All USA Title IDs [BLUS]
echo 11) Check/Dump All USA Title IDs [NPUB]
echo 12) Check/Dump All USA Title IDs [NPUA]
echo.
%cocolor% 06
echo 13) Check/Dump All EUROPE Title IDs [BCES]
echo 14) Check/Dump All EUROPE Title IDs [BLES]
echo 15) Check/Dump All EUROPE Title IDs [NPEB]
echo 16) Check/Dump All EUROPE Title IDs [NPEA]
echo.
%cocolor% 08
echo 17) Check/Dump All ASIA Title IDs [BCAS]
echo 18) Check/Dump All ASIA Title IDs [BLAS]
echo 19) Check/Dump All ASIA Title IDs [NPHB]
echo 20) Check/Dump All ASIA Title IDs [NPHA]
echo.
%cocolor% 07
echo 21) Check/Dump All HK Title IDs [BCKS]
echo 22) Check/Dump All HK Title IDs [BLKS]
echo 23) Check/Dump All HK Title IDs [NPKB]
echo 24) Check/Dump All HK Title IDs [NPKA]
echo.
%cocolor% 0d
echo C) Enter Custom Title ID
echo.
%cocolor% 0e
echo X) Exit Menu
echo.

set /p titleChoice=


if %titleChoice%==C goto custom
if %titleChoice%==c goto custom

if %titleChoice%==X goto end
if %titleChoice%==x goto end

if %titleChoice% gtr 24 goto start


if %titleChoice%==1 goto all

if %titleChoice%==2 goto psn
if %titleChoice%==3 goto disc

if %titleChoice%==4 set isRegion=JPN&&set titleIDRegionCode=BCJS&&goto region
if %titleChoice%==5 set isRegion=JPN&&set titleIDRegionCode=BLJM&&goto region
if %titleChoice%==6 set isRegion=JPN&&set titleIDRegionCode=NPJB&&goto region
if %titleChoice%==7 set isRegion=JPN&&set titleIDRegionCode=BLJS&&goto region
if %titleChoice%==8 set isRegion=JPN&&set titleIDRegionCode=NPJA&&goto region

if %titleChoice%==9 set isRegion=USA&&set titleIDRegionCode=BCUS&&goto region
if %titleChoice%==10 set isRegion=USA&&set titleIDRegionCode=BLUS&&goto region
if %titleChoice%==11 set isRegion=USA&&set titleIDRegionCode=NPUB&&goto region
if %titleChoice%==12 set isRegion=USA&&set titleIDRegionCode=NPUA&&goto region

if %titleChoice%==13 set isRegion=EUR&&set titleIDRegionCode=BCES&&goto region
if %titleChoice%==14 set isRegion=EUR&&set titleIDRegionCode=BLES&&goto region
if %titleChoice%==15 set isRegion=EUR&&set titleIDRegionCode=NPEB&&goto region
if %titleChoice%==16 set isRegion=EUR&&set titleIDRegionCode=NPEA&&goto region

if %titleChoice%==17 set isRegion=ASIA&&set titleIDRegionCode=BCAS&&goto region
if %titleChoice%==18 set isRegion=ASIA&&set titleIDRegionCode=BLAS&&goto region
if %titleChoice%==19 set isRegion=ASIA&&set titleIDRegionCode=NPHB&&goto region
if %titleChoice%==20 set isRegion=ASIA&&set titleIDRegionCode=NPHA&&goto region

if %titleChoice%==21 set isRegion=HK&&set titleIDRegionCode=BCKS&&goto region
if %titleChoice%==22 set isRegion=HK&&set titleIDRegionCode=BLKS&&goto region
if %titleChoice%==23 set isRegion=HK&&set titleIDRegionCode=NPKB&&goto region
if %titleChoice%==24 set isRegion=HK&&set titleIDRegionCode=NPKA&&goto region




:all
cls
echo Check All Possible Title IDs
echo.
echo.

pause

set titleID=BLES01807

if not exist "%dumpPath%" mkdir "%dumpPath%"

goto setServer


:psn
cls
echo Check All PSN Title IDs
echo.
echo.

pause

set titleID=BLES01807

if not exist "%dumpPath%" mkdir "%dumpPath%"

goto setServer


:disc
cls
echo Check All Disc Title IDs
echo.
echo.

pause

set titleID=BLES01807

if not exist "%dumpPath%" mkdir "%dumpPath%"

goto setServer



:region
cls
echo Check All %isRegion% Title IDs
echo.
echo.

:: Region Start
if %isRegion%==JPN (
set dumpPath=%root%\dump\JPN
set titleIDNumber=55000
set titleIDNumber2=60000
)

if %isRegion%==EUR (
set dumpPath=%root%\dump\EUR
set titleIDNumber=00000
)

if %isRegion%==USA (
set dumpPath=%root%\dump\USA
set titleIDNumber=30000
)

if %isRegion%==HK (
set dumpPath=%root%\dump\HK
set titleIDNumber=20000
)

if %isRegion%==ASIA (
set dumpPath=%root%\dump\ASIA
set titleIDNumber=50000
)

set isLoop=1
set return=regionL

:regionL
if %titleIDNumber%==%titleIDNumberMax% goto region

if %isLoop%==1 set /a titleIDNumber=%titleIDNumber%+1

setlocal ENABLEDELAYEDEXPANSION

for %%a in (%titleIDNumber%) do (
    for /f "tokens=1-5" %%F in ("%%a") do (
	   set /a num=%%F
       set zeros=
       if !num! gtr 10000 set zeros=none
       if !num! lss 10000 set zeros=0
       if !num! lss 1000 set zeros=00
       if !num! lss 100 set zeros=000
       if !num! lss 10 set zeros=0000
       set "padding=!zeros!"
       echo !padding!>"%temp%\padding.tmp"
    )
)

endlocal

set /p padding=<"%temp%\padding.tmp"

set titleID=%titleIDRegionCode%%padding%%titleIDNumber%
if %padding%==none set titleID=%titleIDRegionCode%%titleIDNumber%

echo %titleID%
echo.
::pause

if not exist "%dumpPath%" mkdir "%dumpPath%"

goto setServer


:custom
cls
echo Enter Custom Title ID and press ENTER:
echo.
echo.

set /p titleID=

if not exist "%dumpPath%" mkdir "%dumpPath%"

goto setServer



:setServer
set serverA=%prefixURL%a0.ww.np.dl.playstation.net/tpl/np/%titleID%/%titleID%-ver.xml-ver.xml
set serverB=%prefixURL%b0.ww.np.dl.playstation.net/tppkg/np/%titleID%/%titleID%-ver.xml-ver.xml

goto dlPkg


:dlPkg
%wget% %disableCertCheck% %userAgent% -O "%dumpPath%\%titleID%.xml" %serverA%

goto chkBlank


:chkBlank
for %%a in ("%dumpPath%\%titleID%.xml") do (
  if %%~za equ 0 (
	set isBlankXML=1
  ) else (
	set isBlankXML=0
  )
)

goto addList


:addList
if %isBlankXML%==0 (
echo %titleID%>>%updateListComplete%
echo %titleID%>>%updateListActive%
)

if %isBlankXML%==1 (
echo %titleID%>>%updateListComplete%
echo %titleID%>>%updateListFail%
del /f /q "%dumpPath%\%titleID%.xml"
)




if %isLoop%==0 goto start
if %isLoop%==1 goto %return%






:end

exit
