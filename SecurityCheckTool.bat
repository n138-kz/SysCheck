@echo off
set rnd=%RANDOM%

set now=%DATE:/=%_%TIME::=%
set now=%now: =0%



openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto isNotSU
rem   管理者権限で実行中
goto chkSU_End
 
:isNotSU 
rem 非管理者権限で実行中
echo 管理者権限で実行してください。
echo Please execute with administrator privileges.
timeout -1
exit
:chkSU_End



if not exist "C:\_icts" goto chkWorkDir_End
rem 作業フォルダが既にある場合
echo 作業フォルダ(C:\_icts)を見つけました。作業フォルダを削除しても良いですか？
set /P sakujokakunin="Y/n > "
set sakujokakunin=%sakujokakunin:y=Y%
if "%sakujokakunin%" == "Y" goto exeRmdir
echo 作業フォルダを削除して再実行してください
echo Please try again for delete the directory
timeout -1
exit
:exeRmdir
rmdir /S /Q "C:\_icts"

rem 作業フォルダが無い場合
:chkWorkDir_End



if not exist "C:\_icts" mkdir "C:\_icts"


echo アカウントポリシー取得中
net accounts > "C:\_icts\config accounts policy@%COMPUTERNAME%.txt"

echo Bootテーブル取得中
bcdedit > "C:\_icts\config Windows_Boot_Loader_Boot_Manager@%COMPUTERNAME%.txt"

echo ユーザフォルダ一覧取得中
dir /s %USERPROFILE%  > "C:\_icts\User Dirctory List@%COMPUTERNAME%.txt"

echo チェックツール情報取得中
echo %~nx0 > "C:\_icts\Tool Version@%COMPUTERNAME%.txt"

echo システム情報取得中
systeminfo > "C:\_icts\show system info@%COMPUTERNAME%.txt"

echo ネットワーク情報取得中
ipconfig /all > "C:\_icts\ipconfig _all@%COMPUTERNAME%.txt"

echo ユーザ情報取得中
net user %USERNAME% > "C:\_icts\show userinfo@%COMPUTERNAME%.txt"

echo ユーザ一覧取得中
net user > "C:\_icts\config user list@%COMPUTERNAME%.txt"

echo 構成情報取得中
net config workstation  > "C:\_icts\config workstation@%COMPUTERNAME%.txt"

echo 共有フォルダ情報取得中
net share > "C:\_icts\config share folder@%COMPUTERNAME%.txt"

echo セッション情報取得中
net session > "C:\_icts\show server session@%COMPUTERNAME%.txt"

echo インストールプログラム(パターン:A)取得中
wmic product get name,version /format:csv > "C:\_icts\Installed Apps _csv@%COMPUTERNAME%.csv"

echo インストールプログラム(パターン:E)取得中
wmic product get name > "C:\_icts\Installed Apps _plain@%COMPUTERNAME%.txt"
wmic product get version >> "C:\_icts\Installed Apps _plain@%COMPUTERNAME%.txt"

echo システムイベントログ取得中
wevtutil epl System "C:\_icts\log systemlog@%COMPUTERNAME%.evtx"

echo TPM構成情報取得中
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE >> "C:\_icts\config TPM@%COMPUTERNAME%.txt"

echo スクリーンロック情報取得中
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /V ScreenSaveTimeOut >> "C:\_icts\config ScreenLock with Timeout@%COMPUTERNAME%.txt"
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /V ScreenSaverIsSecure >> "C:\_icts\config ScreenLock with Timeout@%COMPUTERNAME%.txt"



echo ZIPアーカイブ中
powershell compress-archive "C:\_icts" "%USERPROFILE%\Desktop\%USERNAME%_%COMPUTERNAME%_%now%.zip"

move "%USERPROFILE%\Desktop\%USERNAME%_%COMPUTERNAME%_%now%.zip" "%~dp0"

echo 作業フォルダ削除中
rmdir /S /Q "C:\_icts"

echo %~dp0%USERNAME%_%COMPUTERNAME%_%now%.zip にファイルを保存しました。
explorer %~dp0
echo 指定されたフォルダへアップロードし担当者へ報告してください。

echo 完了

echo 継続するには何かキーを押してください。
timeout 60 > nul 2>&1
