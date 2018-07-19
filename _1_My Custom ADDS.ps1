### to Add ADDS role on the server

$server = ""
$cred = Get-Credential

Get-Item WSMan:\localhost\Client\TrustedHosts 

Install-WindowsFeature –Name AD-Domain-Services `
    –ComputerName $server `
    -IncludeManagementTools -Credential $cred
    
    
### To Install first domain controller in the New Forest


Invoke-Command –ComputerName $server -Credential $cred –ScriptBlock {

Import-Module ADDSDeployment
Install-ADDSForest `
    -SafeModeAdministratorPassword `
        (ConvertTo-SecureString 'Intel@123' -AsPlainText -Force) `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "Win2012" `
    -DomainName "TestLab.com" `
    -DomainNetbiosName "TestLab" `
    -ForestMode "Win2012" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
    -SafeModeAdministratorPassword `
        (ConvertTo-SecureString 'Intel@123' -AsPlainText -Force)

}

#"Intel@123" | gm

#Add domain conytroller to existing domain

$cred = Get-Credential TestLab\Administrator
Invoke-Command -ComputerName $server1 -ScriptBlock{

Import-Module ADDSDeployment
Install-ADDSDomainController `
    -SafeModeAdministratorPassword `
        (ConvertTo-SecureString 'Intel@123' -AsPlainText -Force) `
    -NoGlobalCatalog:$false `
    -CreateDnsDelegation:$false `
    -CriticalReplicationOnly:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName "idea.com" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -ReplicationSourceDC "$server1.TestLab.com" `
    -SiteName "Default-First-Site-Name" `
    -Credential $using:cred `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Confirm:$False `
    -Force:$true
}


# Once fully restarted and promoted, query for a fresh list of DCs.
# Notice our new DC in the list.
Get-ADDomainController -Filter * |Format-Table Name, Site, IPv4Address -AutoSize

## Create Active Directory OU by default it wont have accedental deletion prevention not enabled
New-ADOrganizationalUnit -Name MAH -Credential $cred -Server $server 

##To enable Accedential deletion property
Set-ADOrganizationalUnit -Identity "OU=MAH,DC=$server,DC=com" -ProtectedFromAccidentalDeletion:$TRUE
 
Set-ADOrganizationalUnit -Identity "OU=MAH,DC=$server,DC=com" -description "This the OU for managing the MYDREAMHOME ORG Infrastructure"

## to Create the OU Hiercharchy
New-ADOrganizationalUnit -Name:"PUNE" -Path:"OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"NAGPUR" -Path:"OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"PUNE Desktops" -Path:"OU=PUNE,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"PUNE LAPTOPS" -Path:"OU=PUNE,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"PUNE USERS" -Path:"OU=PUNE,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"PUNE SERVERS" -Path:"OU=PUNE,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"NAGPUR DESKTOPS" -Path:"OU=NAGPUR,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"NAGPUR USERS" -Path:"OU=NAGPUR,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"NAGPUR LAPTOPS" -Path:"OU=NAGPUR,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred
New-ADOrganizationalUnit -Name:"NAGPUR SERVERS" -Path:"OU=NAGPUR,OU=MAH,DC=TestLab,DC=com" -ProtectedFromAccidentalDeletion:$true -Server:"$server" -Credential $cred


# List of all domain controllers
Get-ADDomainController -Filter * | Format-Table Name, Domain, Forest, Site, IPv4Address, OperatingSystem, OperationMasterRoles -AutoSize

## Can create a userwith just name but it will be disabled by default
New-ADUser Ron


##Then To enable it
$pw =Read-Host "Password" -AsSecureString
Get-ADUser ron |Set-ADAccountPassword -NewPassword $pw

##Create Account, enable it and set password too
New-ADUser M2ACC -Enabled $true -AccountPassword $(ConvertTo-SecureString "Intel@123" -AsPlainText -Force)

# Import users from CSV
Import-CSV ".\users.csv" | New-ADUser 

# Import users from CSV, set password, enable
Import-CSV ".\users.csv" | 
    New-ADUser `
        -Enabled $True `
        -AccountPassword $(ConvertTo-SecureString "Intel@123" -AsPlainText -Force)

# Import users from CSV, set other properties on import
Import-CSV ".\users.csv" | 
    New-ADUser `
        -Enabled $True `
        -AccountPassword $(ConvertTo-SecureString "Intel@123" -AsPlainText -Force) `
        -Company 'TestLab, Com'

# Import users from CSV, set destination OU
Import-CSV ".\users.csv" | 
    New-ADUser `
        -Enabled $True `
        -AccountPassword $(ConvertTo-SecureString "P@55word" -AsPlainText -Force) `
        -Company 'TestLab, Com.' `
        -Path 'OU=Pune Users,OU=Pune,OU=MAH,DC=TestLab,DC=com'



# Import users from CSV when the columns do not match

New-ADOrganizationalUnit NewUsers

Import-CSV ".\newusers.csv" | ogv

# MUST INCLUDE NAME AND SAMACCOUNTNAME ON IMPORT

Import-CSV ".\newusers.csv" | Select-Object Title, Department, City, State, Office, EmployeeID, `
    @{name='name';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='samAccountName';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='displayName';expression={$_.'First Name'+' '+$_.'Last Name'}}, `
    @{name='givenName';expression={$_.'First Name'}}, `
    @{name='surName';expression={$_.'Last Name'}}, `
    @{name='path';expression={'OU=Pune users,OU = Pune,OU=MAH,DC=TestLab,DC=com'}} |
    Out-GridView

Invoke-Command -ComputerName psdemo -Credential $cred -ScriptBlock {
Import-CSV "c:\users\administrator\desktop\newusers.csv" | Select-Object Title, Department, City, State, Office, EmployeeID, `
    @{name='name';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='samAccountName';expression={($_.'First Name'.substring(0,3)+$_.'Last Name').substring(0,7).toLower()}}, `
    @{name='displayName';expression={$_.'First Name'+' '+$_.'Last Name'}}, `
    @{name='givenName';expression={$_.'First Name'}}, `
    @{name='surName';expression={$_.'Last Name'}} |
    New-ADUser -ChangePasswordAtLogon $true -Enabled $True -AccountPassword $(ConvertTo-SecureString "Intel@123" -AsPlainText -Force) -Path 'OU=Pune users,OU = Pune,OU=MAH,DC=TestLab,DC=com' -PassThru

}

# How to copy user attributes to another field with PowerShell

# Find all accounts with a Department
# Copy that value into Description
Get-ADUser -LDAPFilter '(Department=*)' -Properties Description, Department |
 Select-Object * -First 5 |
 ForEach-Object {Set-ADObject -Identity $_.DistinguishedName `
  -Replace @{Description=$($_.Department)}}

# Find all accounts with a Department
# Copy that value along with the GivenName and SurName into Description
Get-ADUser -LDAPFilter '(Department=*)' -Properties Description, Department |
 Select-Object * -First 5 |
 ForEach-Object {Set-ADObject -Identity $_.DistinguishedName `
  -Replace @{Description="$($_.GivenName) $($_.SurName) $($_.Department)"}}

# View the results
Get-ADUser -LDAPFilter '(Department=*)' -Properties Description, Department |
 Select-Object * -First 5 |
 Format-Table Name, Description, Department



# ServicePrincipalName on a computer object

Get-ADComputer $server -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName

Set-ADComputer $server -ServicePrincipalNames @{Add='HTTP/myapp.$server.Testlab.com:8080'}

Get-ADComputer $server -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName

Set-ADComputer $server -ServicePrincipalNames @{Remove='HTTP/myapp.$server.TestLab.com:8080'}

Get-ADComputer MY-DC-1 -Properties ServicePrincipalName | Select-Object -ExpandProperty ServicePrincipalName


# Groups

Get-ADGroup Legal

Add-ADGroupMember -Identity Legal -Members Ron
Add-ADGroupMember -Identity Legal -Members (Get-ADUser -Filter 'Office -eq "MVA"')

Get-ADGroup Legal -Properties Members, MemberOf
Get-ADGroup Legal -Properties Members, MemberOf | Select-Object -ExpandProperty Members
Get-ADGroupMember Legal | ogv

# Cross-domain group issues

# Adding/removing members from another forest or domain to groups in Active Directory
# http://blogs.msdn.com/b/adpowershell/archive/2010/01/20/adding-removing-members-from-another-forest-or-domain-to-groups-in-active-directory.aspx
# http://social.technet.microsoft.com/Forums/windowsserver/en-US/b44c5459-b89a-4e7a-bb6f-3cd002635676/how-to-remove-a-domain-user-from-a-group-in-other-domain?forum=winserverpowershell#cd1ade69-0bc9-4ffd-9081-14175b8b944a

Import-Module ActiveDirectory

# This lab forest has three domains:
#    Root         MyDreamHome.com
#    Child        East.MyDreamHome.com
#    Disjointed   Disjointed.MYCorp.com

($f = Get-ADForest)
$f.Domains
$f.GlobalCatalogs

Get-ADDomain -Identity Testlab.com
Get-ADDomain -Identity East.TestLab.com
Get-ADDomain -Identity Disjointed.MYCorp.com

# Create a new universal group in the root domain
New-ADGroup -Name UG_Test -GroupCategory Security -GroupScope Universal -Server $server -Credential $cred 

Get-ADUser -Filter * -Server $server -Credential $cred

# Add a member from the local root domain

Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
Add-ADGroupMember -Identity UG_Test -Members (Get-ADUser -Filter *)
}
# This command fails, because the cmdlet is looking at the local domain
Add-ADGroupMember -Identity UG_Test `
    -Members "CN=Guest,CN=Users,DC=East,DC=$server,DC=com"

# This command fails, because the cmdlet is looking at the local domain even though targeting GC port
Add-ADGroupMember -Identity UG_Test `
    -Members 'CN=Guest,CN=Users,DC=East,DC=$server,DC=com' -Server localhost:3268

# Must get the external domain member by targeting a DC in that domain
# Instead of specifying a DC name, we'll use the domain name itself
# and get a DC name via round robin DNS for the domain.
Add-ADGroupMember -Identity UG_Test `
    -Members (Get-ADUser Guest -Server East.$server.com)
Add-ADGroupMember -Identity UG_Test `
    -Members (Get-ADUser Guest -Server Disjointed.MYCorp.com)

# View the members
Get-ADGroup UG_Test -Properties Members
Get-ADGroupMember UG_Test

# This next command will error, trying to remove a external domain member
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
Remove-ADGroupMember -Identity UG_Test -Confirm:$false `
    -Members (Get-ADUser -Filter * -Server $server.TestLab.com)
    }
# This next command will error. Try looking at just the DistinguishedName.
Remove-ADGroupMember -Identity UG_Test -Confirm:$false `
    -Members (Get-ADUser Guest -Server Disjointed.MYCorp.com).DistinguishedName

# This next command will error, trying to remove a external domain member
$wwiGuest = Get-ADUser Guest -Server Disjointed.MYCorp.com
Remove-ADGroupMember -Identity UG_Test -Confirm:$false -Members $wwiGuest


# View the raw Member attribute contents
Get-ADObject -Identity (Get-ADGroup UG_Test) -Properties Member | Select-Object -ExpandProperty Member

# Selectively remove the multi-value attribute value of the external domain member
Set-ADObject -Identity (Get-ADGroup UG_Test) -Remove @{Member=$((Get-ADUser Guest -Server east.MyDreamHome.com).DistinguishedName)}

# View the members
Get-ADGroupMember UG_Test

# Wipe all group members
Set-ADObject -Identity (Get-ADGroup UG_Test) -Clear Member

# Remove the group
Remove-ADGroup UG_Test



# Delete a batch of users
Get-ADUser -Filter 'Office -eq "MVA"' | Remove-ADUser -WhatIf

Get-ADUser -Filter 'Office -eq "MVA"' | Remove-ADUser

Get-ADUser -Filter 'Office -eq "MVA"' | Remove-ADUser -Confirm:$false


# Empty the AD Recycle Bin (ONLY IN A LAB!)
Get-ADObject -SearchBase (Get-ADDomain).DeletedObjectsContainer -LDAPFilter "(!name=Deleted Objects)" -IncludeDeletedObjects | 
    Remove-ADObject -Confirm:$false



