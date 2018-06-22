#What is object?
#Why do we use Objects in powershell?

Get-Process | Get-Member

Get-Service | Get-Member


start Notepad

(Get-Process -Name notepad).Kill()

Get-EventLog -LogName Application | Get-Member

Get-Member # Helps you display the Properties and Menthods of Object along with the Type of Object that is being Generated

#Playing with objects 

Get-Process | Where {$_.cpu -gt 50}|Sort -Property PM -Descending|select `
            @{Name ="Processname"; Expression={$_.Name}},`
            @{Name ="VM (MB)"; Expression={$_.vm/1MB -as [int]}},`
            @{Name ="PM (MB)"; Expression={$_.Pm/1MB -as [int]}},NPM -First 10

Get-Process | Sort CPU -Descending |Select-Object ProcessName,@{l='cpu';e={[math]::Round($_.cpu,3)}}

(Get-Process).name


(Get-Service -Name BITS).Stop()

Get-Process | Sort-Object -property VM -Descending | Select Handle,VM, PM, Name


Get-Process | Sort VM -desc


Get-Process | select @{N = "PM(MB)";E={$_.PM /1MB -as [int]} },Name, Handle

Get-Process | ConvertTo-HTML | Out-File test1.html

#Selecting Properties

Get-Process | Select-Object -property Name,ID,VM,PM | ConvertTo-Html | Out-File test2.html

#Objects Until the end of PipeLine

Get-Process | Sort-Object VM -descending |Out-File c:\procs.txt

Get-Process | Sort-Object VM -descending | Select-Object Name,ID,VM

Get-Process | Sort VM -descending | gm

Get-Process | Sort VM -descending | Select Name,ID,VM | gm

Get-process |Select ID, @{Name='PM(MB)';Expression={$_.PM /1MB -as [int]}},`
@{Name='VM(GB)';Expression={$_.VM /1GB -as [int]}},@{Name='WS(MB)';Expression={$_.WS /1MB -as [int]}}`
 -First 10



Get-Process | Sort-Object PM -Descending | Select-Object -Property Name, @{Name="PM(MB)"; Expression={$_.PM /1MB -as [int]}},
                                                                         @{N="VM(MB)"; E ={$_.vm /1MB -as [int]}},
                                                                         @{Label="GPU"; E ={$_.CPU}} -First 10 


$a = "<style>"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 10px;border-style: solid;border-color: black;}"
$a = $a + "TD{border-width: 1px;padding: 10px;border-style: solid;border-color: black;}"
$a = $a + "</style>"

Get-WmiObject -Class win32_logicaldisk | Where {$_.drivetype -eq 3} | 
                                    select DeviceID,
                                            @{Name = 'FreeSpace'; E={$_.Freespace/1GB -as [int]}},
                                            @{Name = 'Size'; E={$_.Size/1GB -as [int]}},
                                            @{Name ='%Free';E={$_.Freespace/$_.Size*100}} | 
                                            ConvertTo-Html -Head "<H2>Disk Space Report</H2>" -Body $a|
                                            Out-File C:\Users\Supercoach\Desktop\html.htm

Get-Process | select Name, VM,PM, CPU, NPM -First 10


Get-Process | select Name, @{name = "VM-1"; E= {$_.vm/1MB -as [int]}},@{name = "PM-1"; E= {$_.Pm/1MB -as [int]}}, @{name = "Np-1"; E= {$_.npm/1MB -as [int]}} -First 10


Get-Service | Select -First 12











