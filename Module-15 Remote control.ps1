Help About_remote -ShowWindow
<#
You can run remote commands on a single computer or on multiple computers by using a temporary or persistent connection. You can also
start an interactive session with a single remote computer.


WSMAN overview?
Windows Remote Management is the Microsoft implementation of the WS-Management protocol, a standard SOAP-based, firewall-friendly 
protocol that allows hardware and operating systems from different vendors to interoperate. The WS-Management protocol specification 
provides a common way for systems to access and exchange management information across an information technology (IT) infrastructure.
WS-Management and Intelligent Platform Management Interface (IPMI),along with the Event Collector, are components of the Windows Hardware
Management features. 

The WS-Management protocol is based on the following standard Web service specifications: HTTPS, SOAP over HTTP (WS-I profile), SOAP 1.2, 
WS-Addressing, WS-Transfer, WS-Enumeration, and WS-Eventing. 

WS-Management and WMI?

WS-Management can be used to retrieve data exposed by Windows Management Instrumentation (WMI). You can obtain WMI data with scripts or
applications that use the WS-Management Scripting API or through the WinRM command-line tool. WS-Management supports most of the familiar WMI
classes and operations, including embedded objects. WS-Management can leverage WMI to collect data about resources or to manage resources on a
Windows-based computers. That means that you can obtain data about objects such as disks, network adapters, services, or processes
in your enterprise through the existing set of WMI classes. You can also access the hardware data that is available from the standard WMI IPMI
provider.

"Secreats of Powershell remoting" http://powershellBooks.com
#>

Get-Service -ComputerName
Get-EventLog -ComputerName

#Remoting allowes you to make connection with another computer over http or https. 
#You transmit commands those are executed locally on that machine and trasnmit the results back

Enable-PSRemoting

Get-PSSessionConfiguration

$cred = Get-Credential

$server = "Test1VM"

Ping $server
##When you remote to remote computer your credentials are delegated to remote computer, if you want to run in the cross forest scenerio you can do that with certificates
##it is completly security transperant

Set-Item WSMan:\localhost\Client\TrustedHosts -Value $server –Force
Get-Item WSMan:\localhost\Client\TrustedHosts

Help Pssession

Enter-PSSession -ComputerName $server -Credential $cred #One to one

Enter-PSSession -ComputerName $server

##Execute some commands etc
help Exit-PSSession

$session = New-PSSession -ComputerName Testvm1 -Credential $cred

Get-Service -ComputerName
Get-WmiObject
<#only one hop thats a limitation
#Credssp
Enable-WSManCredSSP
Enable-WSManCredSSP -Role Client -DelegateComputer *.domain.com
#enables second hop in entire domain
Enable-WSManCredSSP -Role server#>


Invoke-Command -ScriptBlock {Get-EventLog -LogName Application -Newest 5}`
-ComputerName $server

Invoke-Command -ScriptBlock {Get-EventLog -LogName Application -Newest 5}`
-ComputerName $server -Credential $cred

Invoke-Command -


Invoke-Command -ScriptBlock {Get-WindowsFeature | Where-object {$_.installstate -eq "Installed"} | Select -Property Name }`
-ComputerName $server -Credential $cred

Invoke-Command -ScriptBlock {Remove-WindowsFeature -Name Telnet-client }`
-ComputerName $server -Credential $cred

# Parallel
Invoke-Command -ScriptBlock {Get-EventLog -log Security -Newest 5} -ComputerName (Get-Content C:\temp\Servers.txt)
$cred = Get-Credential

$servers ="Test1Vm"
foreach($server in $servers)

{
Invoke-Command -ScriptBlock { $date = get-date -Format yyyy-dd-MM 
New-Item -ItemType Directory -Name $Date -Path C:\Users\$env:Username\Desktop
Copy-Item -Path c:\windows\System32\Winevt\Logs\*.evtx -Destination C:\Users\$env:Username\Desktop\$date -Force} -ComputerName $server -Credential $cred

}

$server = "Test1VM"

Invoke-Command -computerName $server -command { Write-Host "Servername is $Using:server" } -Credential $cred

Invoke-Command -computerName $server `
               -command { Powershell.exe -Command {& "c:\users\$Env:Username\desktop\Test.ps1"}} `
               -Credential $cred

Invoke-Command -ComputerName $server -FilePath C:\Users\Supercoach\Desktop\TestProvision.ps1 -Credential $cred


Invoke-Command -computerName Localhost,ServerName `
-command { Get-EventLog Security -newest 200} |`
Where { $_.EventID -eq 1212 }

###
#$servers = Get-Content C:\temp\Servers.txt
$servers = "DC"
foreach ($server in $servers)
{
Invoke-Command -ComputerName $server -ScriptBlock {Get-Service -name BITS | `
Select-object -Property Name,Pscomputername,starttype,Status } -Credential $cred
}

###

$servers = Get-Content C:\temp\Servers.txt

foreach ($server in $servers)
{
Invoke-Command -ComputerName $server -ScriptBlock {D:\ps\Services.ps1} | `
select-object -Property Name,Pscomputername,starttype,Status
}

####
$servers = Get-Content C:\temp\Servers.txt

foreach ($server in $servers)
{
Invoke-Command -ComputerName $server -ScriptBlock {D:\ps\ServerRole.ps1} | select-object -Property Name,Pscomputername,starttype,Status
}

