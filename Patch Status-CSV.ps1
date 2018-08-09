$servers = Get-Content C:\Temp\Servers.txt

foreach($server in $servers){
    $Patches = Gwmi Win32_QuickFixEngineering -ComputerName $Server
    $OS = Gwmi Win32_Operatingsystem -ComputerName $server 
    foreach ($patch in $Patches)
    {
    $Hash = @{

            Computername = $os.__Server;
            OSName = ($os.Name).Split("|")[0]
            Architecture = $OS.OSArchitecture
            InstalledDate= $Patch.InstalledOn;
            HotFixID=$Patch.HotFixID;
            Description=$Patch.Description;
            InstalledBy=$Patch.InstalledBy
            }

    $OBJ = New-Object -TypeName PSObject -Property $Hash
    $OBJ | Export-csv C:\Temp\Patch.csv -Append -NoTypeInformation
    }
}