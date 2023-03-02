# Windows 11

Unorganized collection of notes related to updating to Windows 11

## Old tool bar always showing, especially bad in dark-mode given it is white.

1. Open Registry Editor
2. Go to: `Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced`
3. Change `AlwaysShowMenus` to `0`

## Something else