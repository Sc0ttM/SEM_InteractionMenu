@ECHO OFF

:choice
set /P c=Trigger Scramble Provided By Jer#9999 : Are you sure you want to continue[Y/N]?
if /I "%c%" EQU "Y" goto :gotonext
if /I "%c%" EQU "N" goto :gotono
goto :choice

:gotonext

set /P inp=(Insert a Randoom Trigger event (Example: FKJIF)
goto :jer

:gotono

echo "Operation cancelled! bye bye "
pause
exit

:jer
jer.py "SEM_InteractionMenu:Cuff" "SEM_InteractionMenu:Cu%inp%ff"
jer.py "SEM_InteractionMenu:JailPlayer" "SEM_InteractionMenu:Jail%inp%Player"
jer.py "SEM_InteractionMenu:GlobalChat" "SEM_InteractionMenu:Gl%inp%obalChat
jer.py "SEM_InteractionMenu:CuffNear" "SEM_InteractionMenu:Cuf%inp%fNear"
