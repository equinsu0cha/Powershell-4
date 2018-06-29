function Get-Testsysteminfo{
    <#
    .SYNOPSIS 
    Queruies the system information from Local and remote machine

    .DESCRIPTION
    Queruies the system information from Local and remote machine against multiple remote machine as well as Ipadresss

    .PARAMETER Name
    Specifies the file name.

    .PARAMETER Extension
    Specifies the extension. "Txt" is the default.

    .INPUTS
    None. You cannot pipe objects to Add-Extension.

    .OUTPUTS
    System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE
    C:\PS> extension -name "File"
    File.txt

    .EXAMPLE
    C:\PS> Get-Testsysteminfo -servers Localhost
    This command queries the SYstem information from Localhost

    .EXAMPLE
    C:\PS> Get-Testsysteminfo -servers 192.168.10.0.1
    This command queries the SYstem information from Ipadress Provide

    .LINK
    http://www.fabrikam.com/extension.html

    .LINK
    Set-Testsysteminfo
    #>
    
    
    Param
        (
        [parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        ParameterSetName="Computer")]
        [String[]]
        $Servers,
        [parameter(Mandatory=$False,
        ValueFromPipeline=$False,
        ParameterSetName="Computer")]
        [String[]]
        $Path,

        [parameter(Mandatory=$false,
        ValueFromPipeline=$true,
        ParameterSetName="Ipaddress")]
        [String[]]
        $Ipaddress

        ) 

    foreach ($server  in $servers){
    $testpath = Test-path \\$server\c$\Windows
    if ($testpath){

        $Users = $env:USERNAME
        $OS =Get-WmiObject -Class Win32_Operatingsystem -ComputerName $server
        $CS =Get-WmiObject -Class Win32_Computersystem -ComputerName $server
        $Bios =Get-WmiObject -Class Win32_Bios -ComputerName $server


        $hashtable =[Ordered]@{
        Servername = $OS.__SERVER;
        OSName = ($OS.Name).Split('|')[0];
        OsArchitecture = $OS.OSArchitecture;
        RAM = $CS.TotalPhysicalMemory/1Gb -as [int];
        SerialNuber = $Bios.SerialNumber
        OSBUILD= $OS.WindowsDirectory

        }
        #$hashtable| Get-Member

        $Obj =New-Object -TypeName PSObject -Property $hashtable

        $obj 
    }
    Else {$Server | Out-file $path\Deadservers.txt}
    }
}

Export-ModuleMember -Function Get-Testsysteminfo