@echo off 
@chcp 65001 >nul

::Cores
set red=[40;31m
set amarelo=[40;33m
set verde=[40;32m
set azul=[40;34m
set roxo=[40;35m
set ciano=[40;36m
set branco=[40;37m
set cinza=[40;90m

:: Verifica se o script está sendo executado como administrador

:: Usa o comando `net session`, que só pode ser executado por um administrador

net session >nul 2>&1
if %errorlevel% == 0 (
    echo O script está sendo executado como administrador.
) else (
    echo %red%ERROR: O script NÃO está sendo executado como administrador.%branco%
    echo.
    echo Por favor, execute o script como %verde%administrador.%branco%
    timeout 4 >nul
    exit /b
)

:comeco

cls
title OptimizerX - Menu
mode con: cols=58 lines=9

echo.
echo    [%amarelo%/%branco%]=================[%azul%OptimizerX%branco%]=================[%amarelo%\%branco%]
echo    ││   %ciano%1 - Performance%branco%      I      %ciano%4 - Storage%branco%      ││
echo    ││   %ciano%2 - Ping%branco%             I      %ciano%5 - Bloatware%branco%    ││
echo    ││   %ciano%3 - Input Lag%branco%        I      %ciano%0 - Sair%branco%         ││
echo    [%amarelo%/%branco%]==============[%cinza%github/trajano33%branco%]==============[%amarelo%\%branco%]
echo.

set /p main="Selecione a opção desejada: "
echo.
::Opções 



if "%main%" == "1" (
    goto Performance
) else if "%main%" == "2" (
    goto Ping
) else if "%main%" == "3" (
    goto InputLag
) else if "%main%" == "4" (
    goto storage
) else if "%main%" == "5" (
    goto bloatware
) else if "%main%" == "0" (
    exit
) else (
    echo Opção %red%invalida%branco%!
    timeout 3 >nul
    goto comeco
)

:Performance
title OptimizerX - Performance
echo %red%Desativando%branco% logs temporarios após ligar/desligar o computador 
echo.


:: ID do plano de energia que você deseja duplicar
set "sourcePlanID=e9a42b02-d5df-448d-aa00-03f14749eb61"

:: Duplicar o plano de energia e capturar o GUID do novo plano
for /f "tokens=2 delims=:" %%a in ('powercfg -duplicatescheme %sourcePlanID% 2^>nul') do set "newPlanID=%%a"

:: Limpar qualquer texto extra
set "newPlanID=%newPlanID:~1,36%"

:: Aplicar o plano de energia recém-criado
powercfg /setactive %newPlanID%

echo Plano de energia duplicado e ativado com %verde%sucesso%branco%!
echo.
echo %verde%Ativando%branco% o modo jogo.
echo.
powershell -c "Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1"

timeout 3 >NUL
goto comeco

:Ping
title OptimizerX - Ping

echo Limpando configurações de rede

:: Finalizando todas as conexões TCP/IP
ipconfig /release >nul

:: Pedindo ao DHCP um novo IP
ipconfig /renew >nul

:: Limpando o cache do DNS
ipconfig /flushdns >nul

:: Reseta todos os adptadores 
netsh int ip reset /all >nul

:: Redefinindo o Winsock podendo resolver problemas de rede
netsh winsock reset >nul

:questionping

echo Configurações de rede limpas com %verde%sucesso%branco%!
timeout 3 >nul
cls
echo.
echo Voce pode fazer uma verificação dns para redução do ping, deseja fazer isto?
echo.
echo 1.%verde%Sim%branco% ou 2.%red%Não%branco%
echo.

set /p opicional="Selecione a opção desejada: "

if %opicional% == Sim (
    goto yes
) else if %opicional% == sim (
    goto yes
) else if %opicional% == S (
    goto yes
) else if %opicional% == s (
    goto yes
) else if %opicional% == 1 (
    goto yes
) else if %opicional% == Não (
    goto comeco
) else if %opicional% == Nao (
    goto comeco
) else if %opicional% == não (
    goto comeco
) else if %opicional% == nao (
    goto comeco
) else if %opicional% == N (
    goto comeco
) else if %opicional% == n (
    goto comeco
) else if %opicional% == 2 (
    goto comeco
) else (
    echo Opção %red%invalida%branco%!
    goto questionping
)

:yes

cls
mode con: cols=58 lines=100
echo %amarelo%1-OpenDNS%branco%
ping 208.67.222.222 -n 10

echo.
echo.

echo %red%2-Cloudflare%branco%
ping 1.1.1.1 -n 10

echo.
echo.

echo %roxo%3-Quad9%branco%
ping 9.9.9.9 -n 10

echo.
echo.

echo %azul%4-Google%branco%

echo.
echo.
ping 8.8.8.8 -n 10

echo.
echo.
echo Qual dessas opções teve um menor tempo médio de resposta?
set ipopen=208.67.222.222
set ipopen2=208.67.220.220

set ipcloud=1.1.1.1
set ipcloud2=1.0.0.1

set ipgoogle=8.8.8.8
set ipgoogle2=8.8.4.4

set ipquad=9.9.9.9
set ipquad2=149.112.112.112


:questiondns
echo.
set /p dns2="Selecione a opção desejada: "
echo.

if %dns2% == 1 (
    goto opendns
) else if %dns2% == 2 (
    goto cloudflare
) else if %dns2% == 3 (
    goto quad9
) else if %dns2% == 4 (
    goto google
) else (
        echo Opção %red%invalida%branco%!   
        timeout 3 >nul
        goto questiondns
)


:opendns

echo %ciano%Setando o DNS%branco%
echo.
netsh interface ip set dns name="Ethernet" source="static" address="%ipopen%"
netsh interface ip add dns name="Ethernet" addr="%ipopen2%" index=2
echo.
echo DNS definido com %verde%sucesso%branco%!
timeout 2 >nul
goto comeco


:cloudflare

echo %ciano%Setando o DNS%branco%
echo.
netsh interface ip set dns name="Ethernet" source="static" address="%ipcloud%"
netsh interface ip add dns name="Ethernet" addr="%ipcloud2%" index=2
echo DNS definido com %verde%sucesso%branco%!
timeout 2 >nul
goto comeco

:quad9

echo %ciano%Setando o DNS%branco%
echo.
netsh interface ip set dns name="Ethernet" source="static" address="%ipquad%"
netsh interface ip add dns name="Ethernet" addr="%ipquad2%" index=2
echo DNS definido com %verde%sucesso%branco%!
timeout 2 >nul
goto comeco

:google

echo %ciano%Setando o DNS%branco%
echo.
netsh interface ip set dns name="Ethernet" source="static" address="%ipquad%"
netsh interface ip add dns name="Ethernet" addr="%ipquad2%" index=2
echo DNS definido com %verde%sucesso%branco%!
timeout 2 >nul
goto comeco


:inputLag
title OptimizerX - InputLag

echo %red%Desativando%branco% Temporizadores Sinteticos 
echo.

bcdedit /set useplatformtick yes >nul

bcdedit /set disabledynamictick yes >nul

bcdedit /deletevalue useplatformclock >nul

timeout 3 >nul

echo InputLag removido com %verde%sucesso%branco%

timeout 2>nul

goto comeco

:storage
title OptimizerX - Storage

cls
echo.
echo %red%Removendo%branco% arquivos temporarios
echo.

rd /s /q %temp%
rd /s /q C:\Windows\Temp
rd /s /q %prefetch%
rd /s /q C:\Windows\SoftwareDistribution\Download


:: Desativando a hirbanação ao delsigar o computador
echo.
echo %red%Desativando%branco% arquivos de hirbanação do Windows
powercfg.exe /hibernate off >nul

echo.
echo Arquivos removidos com %verde%sucesso%branco%
timeout 2>nul
goto comeco

:bloatware
setlocal enabledelayedexpansion
cls
mode con: cols=30 lines=3
set "programs=Microsoft.3DBuilder Microsoft.BingWeather Microsoft.WindowsCalculator Microsoft.WindowsCalendar Microsoft.WindowsCamera Microsoft.GetHelp Microsoft.Getstarted Microsoft.windowscommunicationsapps Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftSolitaireCollection Microsoft.Money Microsoft.News Microsoft.Office.OneNote Microsoft.People Microsoft.Windows.Photos Microsoft.SkypeApp Microsoft.StorePurchaseApp Microsoft.Tips Microsoft.XboxApp Microsoft.XboxGameOverlay Microsoft.XboxGamingOverlay Microsoft.XboxSpeechToTextOverlay Microsoft.XboxGameBar Microsoft.XboxGameDVR Microsoft.GrooveMusic Microsoft.ZuneMusic Microsoft.OneDrive Microsoft.OfficeHub Microsoft.Cortana Microsoft.FeedbackHub Microsoft.YourPhone"


for %%i in (%programs%) do (
    cls
    echo Carregando, aguarde...
    powershell -Command "if (Get-AppxPackage -Name %%i -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"

    REM Verificar o código de erro e definir cor com expansão atrasada
    if !errorlevel!==0 (
        set "color%%i=!ciano!"
    ) else (
        set "color%%i=!red!"
    )
)

cls
mode con: cols=94 lines=27
title OptimizerX - Debloater
echo.
echo.
echo    ╔═════════════════════════════════════════════════════════════════════════════════════╗
echo    ║            v1.0 BETA             █ %azul%Debloater%branco%  █      By: %cinza%github.com/trajano33%branco%       ║ 
echo    ╠═════════════════════════════════════════════════════════════════════════════════════╣
echo    ║     %colorMicrosoft.3DBuilder%1 -  3D Builder%branco%                    █    %colorMicrosoft.StorePurchaseApp%17 -  Store Purchase App%branco%                ║
echo    ║     %colorMicrosoft.BingWeather%2 -  Bing Weather%branco%                  █    %colorMicrosoft.Tips%18 -  Tips%branco%                              ║
echo    ║     %colorMicrosoft.WindowsCalculator%3 -  Calculator%branco%                    █    %colorMicrosoft.XboxApp%19 -  Xbox App%branco%                          ║
echo    ║     %colorMicrosoft.WindowsCalendar%4 -  Calendar%branco%                      █    %colorMicrosoft.XboxGameOverlay%20 -  Xbox Game Overlay%branco%                 ║  
echo    ║     %colorMicrosoft.WindowsCamera%5 -  Camera%branco%                        █    %colorMicrosoft.XboxGamingOverlay%21 -  Xbox Gaming Overlay%branco%               ║ 
echo    ║     %colorMicrosoft.GetHelp%6 -  Get Help%branco%                      █    %colorMicrosoft.XboxSpeechToTextOverlay%22 -  Xbox Speench To Text Overlay%branco%      ║
echo    ║     %colorMicrosoft.Getstarted%8 -  Mail and Calendar%branco%             █    %colorMicrosoft.XboxGameBar%24 -  Xbox Gabe DVR%branco%                     ║
echo    ║     %colorMicrosoft.windowscommunicationsapps%9 -  Microsoft Office Hub%branco%          █    %colorMicrosoft.XboxGameDVR% 25 -  Groove Music%branco%                     ║
echo    ║    %colorMicrosoft.MicrosoftSolitaireCollection%10 -  Microsoft Solitaire%branco%           █    %colorMicrosoft.GrooveMusic%26 -  Movies/TV%branco%                         ║
echo    ║    %colorMicrosoft.Money%11 -  Money%branco%                         █    %colorMicrosoft.ZuneMusic%27 -  OneDrive%branco%                          ║
echo    ║    %colorMicrosoft.News%12 -  News%branco%                          █   %colorMicrosoft.OneDrive%28 -  Office Hub%branco%                         ║
echo    ║    %colorMicrosoft.Office.OneNote%13 -  OneNote%branco%                       █    %colorMicrosoft.Cortana%29 -  Cortana%branco%                           ║
echo    ║    %colorMicrosoft.People%14 -  People%branco%                        █    %colorMicrosoft.FeedbackHub%30 -  Feedback Hub%branco%                      ║
echo    ║    %colorMicrosoft.Windows.Photos%15 -  Photos%branco%                        █    %colorMicrosoft.YourPhone%31 -  Your Phone%branco%                        ║
echo    ║    %colorMicrosoft.SkypeApp%16 -  Skype%branco%                         █    %ciano%32 -  Remover todos os bloatwares%branco%       ║
echo    ╠═════════════════════════════════════════════════════════════════════════════════════╣
echo    ║                              ║      %red%0 Sair%branco%      ║                                   ║ 
echo    ╚═════════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p choice="Escolha uma opção (0-32): "

if "%choice%"=="1" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.3DBuilder* | Remove-AppxPackage"
    echo 3D Builder %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="2" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.BingWeather* | Remove-AppxPackage"
    echo Bing Weather %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="3" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCalculator* | Remove-AppxPackage"
    echo Calculator %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="4" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCalendar* | Remove-AppxPackage"
    echo Calendar %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="5" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCamera* | Remove-AppxPackage"
    echo Camera %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="6" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.GetHelp* | Remove-AppxPackage"
    echo Get Help %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="7" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Getstarted* | Remove-AppxPackage"
    echo Get Started %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="8" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"
    echo Mail and Calendar %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="9" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
    echo Microsoft Office Hub %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="10" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
    echo Microsoft Solitaire Collection %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="11" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Money* | Remove-AppxPackage"
    echo Money %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="12" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.News* | Remove-AppxPackage"
    echo News %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="13" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Office.OneNote* | Remove-AppxPackage"
    echo OneNote %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="14" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.People* | Remove-AppxPackage"
    echo People %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="15" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Windows.Photos* | Remove-AppxPackage"
    echo Photos %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="16" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.SkypeApp* | Remove-AppxPackage"
    echo Skype %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="17" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.StorePurchaseApp* | Remove-AppxPackage"
    echo Store Purchase App %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="18" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Tips* | Remove-AppxPackage"
    echo Tips %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="19" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxApp* | Remove-AppxPackage"
    echo Xbox App %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="20" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
    echo Xbox Game Overlay %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="21" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
    echo Xbox Gaming Overlay %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="22" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
    echo Xbox Speech To Text Overlay %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="23" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameBar* | Remove-AppxPackage"
    echo Xbox Game Bar %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="24" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameDVR* | Remove-AppxPackage"
    echo Xbox Game DVR %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="25" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.GrooveMusic* | Remove-AppxPackage"
    echo Groove Music %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="26" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.ZuneMusic* | Remove-AppxPackage"
    echo Movies & TV %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="27" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.OneDrive* | Remove-AppxPackage"
    echo OneDrive %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="28" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.OfficeHub* | Remove-AppxPackage"
    echo Office Hub %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="29" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.Cortana* | Remove-AppxPackage"
    echo Cortana %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="30" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.FeedbackHub* | Remove-AppxPackage"
    echo Feedback Hub %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="31" (
    powershell -command "Get-AppxPackage -allusers *Microsoft.YourPhone* | Remove-AppxPackage"
    echo Your Phone %red%removido%branco% com %verde%sucesso%branco%!
    timeout 2 >nul
    goto bloatware
) else if "%choice%"=="32" (
    echo %red%Removendo%branco% todos os bloatwares...
    powershell -command "Get-AppxPackage -allusers *Microsoft.3DBuilder* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.BingWeather* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCalculator* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCalendar* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.WindowsCamera* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.GetHelp* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Getstarted* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Money* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.News* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Office.OneNote* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.People* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Windows.Photos* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.SkypeApp* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.StorePurchaseApp* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Tips* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxApp* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameBar* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.XboxGameDVR* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.GrooveMusic* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.ZuneMusic* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.OneDrive* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.OfficeHub* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.Cortana* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.FeedbackHub* | Remove-AppxPackage"
    powershell -command "Get-AppxPackage -allusers *Microsoft.YourPhone* | Remove-AppxPackage"
    echo.
    echo Todos os bloatwares %red%removidos%branco% com %verde%sucesso%branco%!
    timeout 3 >nul
    goto bloatware
) else if "%choice%"=="0" (
    goto comeco
) else (
    echo Opção %red%inválida%branco%. Tente novamente.
    timeout 2 >nul
    goto bloatware
)