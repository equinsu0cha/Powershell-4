$path1 ="HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
$path2 ="HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

Get-ItemProperty -Path $path1,$path2 | Where {$_.displayname}| Where {$_.Publisher -notlike "*Microsoft*"}|
                            Select Displayname, Displayversion,Publisher | Out-GridView