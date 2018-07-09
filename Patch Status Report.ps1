$reportpath = "d:\"
$date = (Get-Date).tostring("dd-MM-yyyy")
$reportname = "PatchReport-$date.htm"
$PatchReport = $reportPath + $reportName 
$Servers = Get-Content "C:\Temp\Servers.txt"
$datess = (Get-Date).ToString("dd-MM-yyyy hh-mm")

$header = " 
<html> 
<head> 
<title>Patch Report</title> 
<STYLE> 
<!-- 
td { 
font-family: Calibri; font-size: 12px; border-top: 1px solid #999999; border-right: 1px solid #999999; border-bottom: 1px solid #999999; 
border-left: 1px solid #999999; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; } 
body { 
margin-left: 5px; margin-top: 5px; margin-right: 0px; margin-bottom: 10px; 

table { 
border: thin solid #000000; 
} 
--> 
</style> 
</head> 
<body> 
<table width='100%'> 
<tr bgcolor='#32CD32'> 
<td colspan='7' height='30' align='center'> 
<font face='calibri' color='#003399' size='4'><strong>Patch Report: $datess</strong></font> 
</td> 
</tr> 
</table> 
" 

Add-Content $PatchReport $header 

# Create and write Table header for report 

$tableHeader = " 
<table width='100%'><tbody> 
<tr bgcolor=#32CD32> 
<td width='7%' align='center'>Computername</td> 
<td width='7%'  align='center'>Architecture</td> 
<td width='7%' align='center'>HotFixID</td> 
<td width='7%' align='center'>InstalledBy</td> 
<td width='7%' align='center'>OSName</td> 
<td width='7%' align='center'>Description</td> 

</tr> 
" 
Add-Content $PatchReport $tableHeader;

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
    $dataRow = "<tr> 
            <td width='7%' align='center'>$($OBJ.Computername)</td>
            <td width='7%' align='center'>$($OBJ.Architecture)</td>
            <td width='7%' align='center'>$($OBJ.HotFixID)</td>
            <td width='7%' align='center'>$($OBJ.InstalledBy)</td>
            <td width='7%' align='center'>$($OBJ.OSName)</td>
            <td width='7%' align='center'>$($OBJ.Description)</td>
            </tr> "
    Add-Content $PatchReport $dataRow;
    }
  }

