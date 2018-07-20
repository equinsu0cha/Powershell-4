<#Comment below line after successfully recording the password in Pass.txt file. 
This is not the most secure way of passing password.#>
$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content c:\temp\pass.txt
$Password = Get-Content c:\temp\pass.txt | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PsCredential($username, $Password)