@echo off
Title PNG to DDS to Skin
Color 0A
SET devPath=%~dp0

SET /p id="Enter Skin Name: "

Call :Browse4Folder "Where are the image files located?" "c:\scripts"
cd %Location%
if exist export rmdir export /q /s
xcopy /s %devPath%exporter.py .
xcopy /s %devPath%texconv.exe .
python exporter.py
rm -f exporter.py
rm -f texconv.exe
cd export

zip -r %id%.zip .

xcopy /s %id%.zip %UserProfile%\Documents\Trackmania\Skins\Models\CarSport

pause & exit
::***************************************************************************
:Browse4Folder
set Location=
set vbs="%temp%\_.vbs"
set cmd="%temp%\_.cmd"
for %%f in (%vbs% %cmd%) do if exist %%f del %%f
for %%g in ("vbs cmd") do if defined %%g set %%g=
(
    echo set shell=WScript.CreateObject("Shell.Application"^) 
    echo set f=shell.BrowseForFolder(0,"%~1",0,"%~2"^) 
    echo if typename(f^)="Nothing" Then  
    echo wscript.echo "set Location=Dialog Cancelled" 
    echo WScript.Quit(1^)
    echo end if 
    echo set fs=f.Items(^):set fi=fs.Item(^) 
    echo p=fi.Path:wscript.echo "set Location=" ^& p
)>%vbs%
cscript //nologo %vbs% > %cmd%
for /f "delims=" %%a in (%cmd%) do %%a
for %%f in (%vbs% %cmd%) do if exist %%f del /f /q %%f
for %%g in ("vbs cmd") do if defined %%g set %%g=
goto :eof
::***************************************************************************