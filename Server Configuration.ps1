#Assign IP address
#
WIN-CR5MT2OV3EI


[String]$Server = read-host -Prompt "Server name"
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $Server –Force
$credential = Get-Credential

<#
enable remote desktop
Disable firewall
Set the update to be automatic
Disable the Server Manager
#>


#Enter-PSSession -ComputerName 192.168.10.30  -Credential $credential

Get-Item WSMan:\localhost\Client\TrustedHosts

#To Install the wmf5.1 on remote computer
#Invoke-Command -ComputerName S2 -ScriptBlock {wusa.exe C:\Users\Administrator\Desktop\Win8.1AndW2K12R2-KB3191564-x64.msu /quiet} -Credential $credential
$credential= Get-Credential
Invoke-Command -ComputerName $server -Credential $credential -ScriptBlock {
#Windows Update
#Record the WUAU settings into an object
$AUSettigns = (New-Object -com "Microsoft.Update.AutoUpdate").Settings
$AUSettigns
$AUSettigns.NotificationLevel = 2
$AUSettigns.Save()

#Server Manager

New-ItemProperty -Path HKCU:\Software\Microsoft\ServerManager -Name DoNotOpenServerManagerAtLogon -PropertyType DWORD -Value "0x1" –Force

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 0

netsh firewall set opmode mode=disable Profile=All #"To disable firewall"
#New-NetIPAddress -InterfaceIndex 12 -IPAddress 192.168.5.9 -PrefixLength 24 -DefaultGateway 192.168.5.2 -AddressFamily IPv4 

#Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("192.168.5.2")

Rename-Computer -NewName S7
Restart-Computer -Force
}

#Sleep 180

$server = "S7"
#Domain Credentials
$credential = Get-Credential
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $Server –Force

Invoke-Command -ComputerName $Server -Credential $credential -ScriptBlock {Add-Computer -DomainName Mohanishmate.com -Credential $using:credential -Restart}


#Set-NetIPAddress -InterfaceIndex 13 -IPAddress 192.168.5.2
#Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("192.168.10.2")


Help Set-VMSwitch -Examples

Get-VMSwitch