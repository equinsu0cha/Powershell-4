##Command Format Anatomy

Get-EventLog -LogName Application -ComputerName Localhost -Newest 10 -Verbose

#Command Naming Convention *Verb-Noun*

Get-Service -Name BITS,AdobeARMservice -ComputerName localhost -RequiredServices

Get-Service

Get-Process

Get-EventLog

## Another example of Running Commands

Get-VM

New-VM -Name TestVm2.0 -MemoryStartupBytes 1GB -NewVHDPath D:\Globomantics\TestVm2.0\TestVm2.0.vhdx -SwitchName Internal -Path D:\Globomantics\TestVm2.0 -Generation 2 -NewVHDSizeBytes 100Gb
Add-VMScsiController -VMName Testvm2.0
Add-VMDvdDrive -VMName Testvm2.0 -Path 'D:\My Important Stuff\MSFT Setup and OS\System Admin\en_windows_server_2012_x64_dvd_915478.iso' -ControllerNumber 1
#Identifying the Number of Verbs used in powershell World

Get-Verb

#Alias or altername name for commands:

Help *Alias*

Gsv # Get-service

PS # Get-Process

help *alias*

help Get-Alias

Get-Alias -Name ps

help New-Alias -Examples

New-Alias -Name "Test" -Value Get-Service

Set-Alias -Name "Test" -Value Get-Process

Test # Executes the Command mapped with this alias

Get-Alias -Name gsv

Get-Alias -Name GM

Get-Alias -Name GWmi


# Parameter name Alias

Get-Command -Name Get-EventLog 

Get-Command -Name Get-EventLog | Select Parameters

Get-Command -Name Get-EventLog | Select-Object -ExpandProperty parameters

(Get-Command -Name Get-EventLog | Select -ExpandProperty parameters).InformationAction

(Get-Command -Name Get-EventLog | Select -ExpandProperty parameters).Computername.aliases

## Truncating commands

Gsv -na BITS,server -comp Localhost -Requi

ps -Na AcroRd32,notepad -Compu Localhost 

#Quick Cheat

Show-Command Get-Service 

Show-Command Get-Process

Get-Service -ComputerName Localhost,Localhost -Name Bits,Server

#Support for external commmands

Ipconfig

Ipconfig /all
Get-Alias
Ipconfig /all 

Ping Localhost
Test-Connection -ComputerName localhost -Count 1

Ping Localhost -t -4

Tracert localhost

netsh interface show Interface 

netsh interface show Interface [name ="OnboardNic"]

netsh interface ipv4 show address

netsh interface ipv4 show Dnsservers

netsh interface ipv4 set dnsservers name="OnboardNic" static 192.168.2.1 Primary

netsh interface ipv4 set Address "OnboardNic" Static 192.168.2.1 255.255.255.0 192.168.2.1

net localgroup Administrators

##Alias or Alternate names for commands

Get-Alias -name md

Get-Alias -Name ps

Get-Alias -Name dir

Get-Alias -Name copy

Get-Alias -Name move



Get-Service