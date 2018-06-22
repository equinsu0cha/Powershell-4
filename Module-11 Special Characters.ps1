# Usage of Special characters and operators
# @() - Designates Array
#'@' - Hashtable Operator @{} or Array operator @{}

# '#' or <#..#> - Commenting operator

 <#Get-EventLog -LogName Application -Newest 10
  Get-EventLog -LogName Application -Newest 10
  Get-EventLog -LogName Application -Newest 10
  Get-EventLog -LogName Application -Newest 10
  Get-EventLog -LogName Application -Newest 10 #>


<#
Get-service -Name Bits
Get-process -Name powershell
#>

# '$' - Represents Variable 
 $name = "Powershell"
 $a
 $servers_Blu
 $numbers 
 $services

# '%' - Foreach operator or Modulus Operator

# '?' - Where Or Where-Object

# '*' - Wild Card Charactor

# '|' - Pipeline Operator

# '=' - Assignment Operator

# '`' - Escape Charactor

$server = "TestServer1"

Write-host "$server contains $server" 

Write-host "`$server contains $server"

Write-host '$server contains $server'## Single Quote never resolve variables

$date = (Get-date).ToString("dd-MM-yyyy hh-mm")
Write-host "Restarting Server $server at $date"
Write-host 'Restarting Server $server at $date'

Get-Service -Name BITS `
            -computername localhost,localhost,localhost,localhost `
            -DependentServices



# '&' - Execution Operator

# '$_.' - Place Holder or Current Object in pipe line

