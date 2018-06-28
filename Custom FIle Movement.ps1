Help Rename-Item -Examples


$dates = (Get-date).ToString("dd-MM-yyyy hh-mm")
New-Item -Path C:\Temp -Name $dates -ItemType Directory

Copy-Item C:\Temp\* -Destination C:\Temp\$dates
$files =Get-ChildItem -Path C:\Temp\$dates| select name

foreach($f in $files.name){
    If ($f -like "*Server*"){
        Rename-Item -Path "C:\Temp\$dates\28-06-2018 10-48NewServers.txt" `
        -NewName ($dates +'-'+ "NewServers.txt")

    }
}