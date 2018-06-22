<#
Getting just what you need
Filter Left
Comparion Operator
Filtering objects out of the pipeline
#>

help about_Arithmetic_Operators -ShowWindow
help about_Logical_Operators -ShowWindow
help about_Comparison_Operators -ShowWindow
help about_Assignment_Operators -ShowWindow
Help about_Operator_Precedence -ShowWindow


###Arithmetic Operations###
$A = 10
$B = 12

$C = "Monday"
$D = "Sunday"

#Addition for INT and concatination for String
$A+$B
$C+"`t" +$D ##`t is for Tab space
$C+"`n" +$D ##`n is new line 

#Subtraction
$A-$B

#Negative Numbers
-$A+$B

#Multiplication
$A*$B

#Division
$A/$B

#Modulus
$B%$A

###Logical Operations###

#Or Operation
0 -Or 0
0 -Or 1
1 -Or 0
1 -Or 1

$false -Or $false
$false -or $true
$true  -or $false
$true  -or $true

#And Operation
0 -and 0
0 -and 1
1 -and 0
1 -and 1

$false -And $false
$false -And $true
$true  -And $false
$true  -And $true

#XOR Operation
0 -Xor 0
0 -Xor 1
1 -Xor 0
1 -Xor 1

$false -Xor $false
$false -Xor $true
$true  -Xor $false
$true  -Xor $true

#Not Operation
-not 0
-not 1
-not $false
-not $true

####Comparison#####

$A -eq $B # Equals to
$A -ne $B # Not Equals to
$A -gt $B # Greater Than
$A -ge $B # Greater than Equals 
$A -lt $B
$A -le $B

##Like Operator
"Monday" -Like "Monda*"
"Pune" -Like "*un*"

##Match Operator
"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" -Match "Saturday" ## Can be Used with regular Expressions
"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" -notmatch "Sunday"

##Contains Operator
"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" -Contains "Friday"
"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" -NotContains "Sunday"
"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" -Contains "Sunday"

##Replace Operator
"Get-Service" -Replace "Get" , "Stop"
'Today is Tuesday' -replace "Tuesday","Monday"

##Practical Usecases
Get-Service | Where-Object {$_.StartType -eq "Manual"} # Displaying Services with Starttype as Manual
Get-Service | Where-Object {$_.Status -eq "Running"} # Displaying Services with Status as Running
Get-Service | Where-Object {($_.Status -eq "Stopped") -and ($_.StartType -eq "Automatic")} # Displaying Services with Status as Stopped and Starttype as Automatic

Get-Process | Where-Object {$_.NPM -gt "100KB"}
Get-Process | Where-Object {$_.PM -gt "50000KB"}
Get-Process | Where-Object {$_.CPU -gt "50"}
Get-Process | Where-Object {$_.CPU -lt "50"}

Get-Service -Name 'WinRM'

Get-Service | where{$_.name -eq "Winrm"}

Get-Service | ?{$_.name -like "Win*"}

Get-Service | ?{$_.name -like "Win*" -and $_.status -eq 'Running'}

## Assignment Operator


$P = 19
$P = 20
$P += 15

$Q = "Monday"
$Q += "Tuesday"

$P = 19
$P -= 2
$P


$P = 19
$P /= 2
$P


$P = 19
$P *= 2
$P

$P = 19

$P++
$p--