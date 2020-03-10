# Feture
# Detail
# License
This is licensed under the [MIT License](LICENSE)

# Use command(ver 1.1)
- `net accounts` アカウントポリシー
- `bcdedit` Bootテーブル
- `dir /s %USERPROFILE%` ユーザフォルダ一覧
- `systeminfo` システム情報
- `ipconfig /all` ネットワーク情報
- `net user %USERNAME%` ユーザ情報
- `net user` ユーザ一覧
- `net config workstation` 構成情報
- `net share` 共有フォルダ情報
- `net session` セッション情報
- `wmic product get name,version /format:csv` インストールプログラム(パターン:A)
- `wmic product get name`, `wmic product get version` インストールプログラム(パターン:E)
- `wevtutil epl System _FILENAME` システムイベントログ
- `reg query HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE` TPM構成情報
- `reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /V ScreenSaveTimeOut`, `reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /V ScreenSaverIsSecure` スクリーンロック情報

