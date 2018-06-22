        
        
        $a =1

        #Basic
        if (Condition)
            {
            Logic1
            }
        Else{
            Logic2
        }

        #Nested
        if (Condition)
        {
            Logic1
        }
        Elseif (Condition2)
        {
            Logic2
        }
        Elseif (Condition3)
        {
            Logic3
        }
        else
        {
            Logic4
        }



        $a =1
        if ($a -ge 2)
        {
            Write-Host "Content of `$a i.e $a is greater than Reference values " -ForegroundColor Red
        }
        elseif ($a -eq 2)
        {
            Write-Host "The reference value is equal to `$a i.e $a."-ForegroundColor Cyan
        }
        else
        {
            Write-Host "The reference value is less than $a or was not created or initialized." -ForegroundColor Green
        }


        #3 datacenter DM2SQL103, INDAPP123, BLUAZE123

$servers ="DM2SQL103", "INDAPP123", "BLUAZE123", "Localhost"

foreach ($server in $servers)
{
#$server = "DM2SQL103"
$testpath = Test-Path -Path \\$server\c$\Windows

    If ($testpath)
    {
        if ($server -match "DM2")
        {
            Write-host "Patch the server and reboot" -ForegroundColor Cyan

        }Elseif ($server -match "IND") {

            Write-Host "Dont Patch Server but Only reboot" -ForegroundColor Red

        }Elseif ($server -match "BLu") {

            Write-Host "Dont Patch Server but Only reboot" -ForegroundColor Yellow

        } Else {
            Write-host "Server is Local computer" -ForegroundColor Yellow
        }

    }
    
    Else {$server |Out-file c:\users\supercoach\servers1.txt -Append}
}




$servers ="DM2SQL103", "INDAPP123", "BLUAZE123", "Localhost"

foreach ($server in $servers){

#$server = "Localhost"

$testpath = Test-Connection -ComputerName $server -Count 1 | Select  StatusCode -ErrorAction SilentlyContinue

    If ($testpath.StatusCode -eq 0)
    {
        if ($server -match "DM2")
        {
            Write-host "Path the server and reboot" -ForegroundColor Cyan

        } Elseif ($server -match "IND") {

            Write-Host "Dont Patch Server but Only reboot" -ForegroundColor Red

        }Elseif ($server -match "BLu") {

            Write-Host "Dont Patch Server but Only reboot" -ForegroundColor Yellow

        } Else {
            Write-host "Server Local computer" -ForegroundColor Yellow
        }

    }Else {$server |Out-file servers.txt -Append}
}


[array]$contents = Get-Content C:\Temp\Servers.txt


Foreach ($c in $contents){

    if ($c -match "f")
    {
       Replace      
    }

}



if ($testpath -eq $true){

}