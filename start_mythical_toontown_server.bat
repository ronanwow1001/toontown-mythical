@echo off

title Toontown Mythical Game Launcher

echo Choose your connection method!
echo.
echo #1 - Localhost
echo #2 - Dev Server
echo #3 - Custom
echo #4 - Miniserver
echo #5 - Prod Server
echo.

:selection

set INPUT=-1
set /P INPUT=Selection: 

if %INPUT%==1 (
    set TT_GAMESERVER=127.0.0.1
) else if %INPUT%==2 (
    set TT_GAMESERVER=167.114.220.172
) else if %INPUT%==4 (
    set TT_GAMESERVER=127.0.0.1
) else if %INPUT%==5 (
    SET TT_GAMESERVER=lw2.ez-webz.com:7198
) else if %INPUT%==3 (
    echo.
    set /P TT_GAMESERVER=Gameserver: 
) else (
	goto selection
)

echo.

if %INPUT%==2 (
    set /P ttUsername="Username: "
    set /P ttPassword="Password: "
) else if %INPUT%==4 (
    set /P ttUsername="Username: "
    set /P ttPassword="Password: "
) else (
    set /P TT_PLAYCOOKIE=Username: 
)

echo.

echo ===============================
echo Starting Toontown ...
echo ppython: "C:\Panda3D-1.10.0\python\ppython.exe"

if %INPUT%==2 (
    echo Username: %ttUsername%
) else if %INPUT%==4 (
    echo Username: %ttUsername%
) else (
    echo Username: %TT_PLAYCOOKIE%
)

echo Gameserver: %TT_GAMESERVER%
echo ===============================

cd ../../

:main
if %INPUT%==2 (
    "C:\Panda3D-1.10.0\python\ppython.exe" -m toontown.toonbase.ToontownStartRemoteDB
) else if %INPUT%==4 (
    "C:\Panda3D-1.10.0\python\ppython.exe" -m toontown.toonbase.ToontownStartRemoteDB
) else (
    "C:\Panda3D-1.10.0\python\ppython.exe" -m toontown.toonbase.ToontownStart
)
loading information for "SOURCE OF TTO PLAY ON MAC.txt":
#!/bin/bash
# Date : 04.07.2012 16:02
# Last revision : 04.07.2012 16:02
# Wine version used : 1.4
# Distribution used to test : Ubuntu 12.04 32bit
# Author : zadarmo3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="Toontown Online"
PREFIX="toontown"
POL_SetupWindow_Init
POL_Debug_Init
POL_System_TmpCreate "$PREFIX"
POL_SetupWindow_presentation "$TITLE" "Disney" "test.toontown.com" "zadarmo3" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "1.4"
POL_SetupWindow_wait "$(eval_gettext 'Installing vcrun2008 and wininet and disabling d3d9 and d3d8 dlls to force the game to use OpenGL')" "$TITLE"
POL_Call POL_Install_wininet
POL_Wine_OverrideDLL "" "d3d9"
POL_Wine_OverrideDLL "" "d3d8"
POL_Call POL_Install_vcrun2008
POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
        POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
        POL_Wine start /unix "$APP_ANSWER"
        POL_Wine_WaitExit
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
        cd "$POL_System_TmpDir"
        POL_Download "http://download.toontown.com/english/currentVersionWIN/Toontown-setup.exe" "69c60198d0d8b28f5ca648c253cf08e8"
        POL_SetupWindow_wait "$(eval_gettext 'Please wait while $TITLE is installed.')" "$TITLE"
        start "start_all.bat"
        goto main
