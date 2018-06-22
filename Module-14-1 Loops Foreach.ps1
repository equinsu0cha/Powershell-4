Help about_foreach -ShowWindow

<#
The Foreach statement (also known as a Foreach loop) is a language construct for stepping through (iterating) a series of values in a 
collection of items. 

The simplest and most typical type of collection to traverse is an array.Within a Foreach loop, it is common to run one or more commands against
each item in an array. #>

foreach($Arg in $args)
{

}

$servers = Get-Content C:\Temp\Servers.txt

foreach($Server in $Servers)
{
Get-Service -Name WinRM -ComputerName $server | select Name, Status,StartType,MachineName

sleep 10
}

## E.g. 1
$numbers = 1,5,4,8,7,5,87,52,655,3214

FOreach($n in $numbers)
{
Write-host "$n" -ForegroundColor Green
sleep 10
}

## E.g. 2
$servers = Get-Content C:\Temp\Servers.txt
foreach($S in $servers)
{

#Restart-Computer -ComputerName $server
Get-EventLog -LogName Application -EntryType Error -Newest 3 -ComputerName $S | select  Source,ID,MachineName,Message
#Get-Service -Name BITS -ComputerName $S | Select Name, DisplayName, Status, StartType, MachineName | Format-Table 

sleep 5
}

## E.g. 3 (Sequential Execution)
$servers = Get-Content C:\Temp\Servers.txt

foreach ($s in $servers){
Restart-computer -computername $server
}

# E.g. 4

foreach ($file in Get-ChildItem)
{
    Write-Host $file
}


$services=Get-Service

Foreach($service in $services){

Write-host  "$($service.Name) : $($service.status)"


}


$processes = Get-Process
foreach($p in $processes){
#Write-host "$($process.name) : $($processes.cpu)" # We are not able to 
if ($p.name -eq 'Notepad')
    {
    Stop-Process -Name $p.Name
    }
}


$servers = Get-Content C:\Temp\Servers.txt

foreach($server in $servers){

Install-windowsfeature -name Telnet-client -computer $Server -includemanagementtools
}

 }Until ((($Statuscode -eq 0 ) -and ($Testpath -eq $true)) -or ($counter -le 3) )