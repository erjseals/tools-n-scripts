# Windows 11

Unorganized collection of notes related to updating to Windows 11

## Old tool bar always showing, especially bad in dark-mode given it is white.

1. Open Registry Editor
2. Go to: `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
3. Change `AlwaysShowMenus` to `0`

## Restore the old context menu (Microsoft might add this as a customizable feature soon).

1. Open Windows Terminal in command prompt
2. run `reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve`
3. restart File Explorer (if it's open)