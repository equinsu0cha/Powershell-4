#0X1: OK (1), Cancel(2)
#0X2: Abort(3), Retry(4), Ignore(5)
#0X3: Yes(6), No(7), Cancel(2)
#0X4: Yes, No
#0X5: Retry(4), Cancel(2)
#0X6: Cancel(2),Try Again(10),Ignore(5)

$wshell = New-Object -ComObject Wscript.Shell
$UIValue=$wshell.Popup("Do you want to proceed",0,"Upgrade Activity",0x6)
$UIValue

If($UIvalue -eq 6)
{
    "Take Some Action"
}

Else {
    "Take Alternate Action"
}


#### Input Box####

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$Path = [Microsoft.VisualBasic.Interaction]::InputBox('Enter a Path to the server file', 'Server Collection File', "Path to the file ")

$servers = Get-Content $Path

Foreach($server in $servers){

$service = Get-Service -Name Bits -ComputerName $server | Select Name, Status,StartType,MachineName

If ($service.status -eq "running"){
    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup("$($service.name) on $server is Running Fine",0,"SQL Upgrade Activity",0x1)
    }
}







######OKCancel, YesNoCancel, YesNo

$msgBoxInput =  [System.Windows.MessageBox]::Show('Would you like to play a game?','Game  input','YesNoCancel','Information')

switch  ($msgBoxInput) {

    'Yes' {
            Write-Host "User Input is Yes" -ForegroundColor Green
          }
      'No'{
            Write-Host "User Input is No" -ForegroundColor Yellow 
          }
  'Cancel'{
            Write-Host "User Input is Cancel" -ForegroundColor Magenta
          }
  }
  
