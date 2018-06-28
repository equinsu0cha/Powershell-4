#$servers = Get-Content -path C:\Temp\Servers.txt
$servers = "Localhost"
foreach($server in $servers){
 $testpath = Test-path \\$server\c$\windows
     If ($testpath){
         Get-wmiobject -Class win32_product -ComputerName $server | 
         Where {$_.vendor -ne "Microsoft corporation"} | Export-Csv C:\Temp\Softwares.csv
         #ConvertTo-Html -Head "Software Inventory"|
         #Out-file c:\temp\Softwareinventory.htm
         #Get-wmiobject -Class win32_product -ComputerName $server | Where {$_.vendor -eq "Adobe corporation"}
     } 
     Else 
     {
        $server |out-file  C:\temp\InAccessibleservers.txt
     }
 
}