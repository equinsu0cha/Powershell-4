## Variables in Powershell are denoted by "$"
help about_variables -ShowWindow
$A 
$Temp
$serrver
$computername
$Temp_variable
$Temp_variable_testing

$a = 12
$b = "Text"

Get-Variable
# Any object within Powershell can be stored in Variable

$a = 1
$b =5
$c = $a + $b 

$a = Get-Date
$b = "Todays Date is $a"

$a = 'Monday'
$b = "Tuesday"
$c = $a + $b


# Casting a Variable 

[int] $a = 1
$a = "Monday"
$a = 19
$a += 15
$a += "test"

[String] $b = "Monday"
$b = 13

[Datetime] $D = Get-date
$d += 12
$d = "Saturday"
$d += "Monday"

$b
$K = 12

$b+$a
$d.GetType()

$b.GetType()
$a.GetType()
##Listing all system variable
Get-Variable

$profile

$PSHOME

$HOME

$ad =$null

$true

$false

$ErrorActionPreference

$WarningPreference

$VerbosePreference


New-Variable -Name Text -Value "Today is sunday"

Set-Variable -Name Text -Value "Today is Monday"

##Modifying Powershell Console using Powershel windows

$Host.UI.RawUI.ForegroundColor ="Green"
$Host.UI.RawUI.BackgroundColor = "Navy blue"
$Host.UI.RawUI.WindowTitle =$(Get-Date)



#Environmental Variables
# Operating system specific variable can be accessed from CMD and Powershell 
cd env:

dir