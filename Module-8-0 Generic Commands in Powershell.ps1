Help *-Object* | select -ExpandProperty Name


New-Object      # Creating new object
ForEach-Object  # Loop
Where-Object    # External Filtering
Compare-Object  # Comparison
Group-Object    # Grouping objects of same type
Measure-Object  # Identifying the count of object
Select-Object   # Selecting specific set of properties
Sort-Object     # Sorts ascending and descinding



#To Identify all the properties of object
Get-Service -Name b* | Format-List -Property *
Help Format-List -ShowWindow

Get-Process -Name POWERPNT | Format-List -Property *
Help Select-Object -ShowWindow

Get-EventLog -LogName Application -Newest 1 | Format-List -Property *
# Usage of Select-object command
Get-Process | select Name,ID, VM,Pm
Get-Process | select Name,ID, VM,PM, cpu

Get-Process | select Name,ID, VM,PM, cpu
Get-EventLog -LogName Application -Newest 2 | select EventID, EntryType,TimeGenerated,Message
Get-service | Select -First 10
 ## Sort Object 
 Get-Service |where {$_.Name -like "B*"}
 Get-Process | Sort-Object -Property CPU -Descending | Select-Object  -First 10


#Usage of Where-object Command
Help Where-Object -ShowWindow

Get-service | Where-Object -FilterScript {$_.status -eq "stopped"}
Get-Service | where {$_.StartType -eq "Automatic"} | Select Name, DisplayName,StartType
Get-Process | where {$_.CPU -lt 100}

Get-service | Where-Object -FilterScript {$_.status -eq "Running"}
Get-service | Where-Object -FilterScript {$_.name -eq "Bits"}
Get-service | Where-Object -FilterScript {$_.Name -like "B*"}
Get-process | Where-Object -FilterScript {$_.Name -like "A*"}
Get-process | Where-Object -FilterScript {$_.cpu -gt 200}

###100 In class
Get-people | where {$_.Age -gt 60}
Get-people | where{ $_.hair -eq "Curly"} # PlaceHolder
Get-people | where{ $_.haircolor -eq "Black"}

#Service Starttype is automatic
Get-Service | Where-Object -FilterScript {$_.StartType -eq "Automatic"} | Select-Object -Property Name, DisplayName,StartType,Status

#Service Starttype is Disabled
Get-Service | Where-Object {$_.StartType -eq "Disabled"} | Select-Object name,DisplayName,StartType,Status
Get-process | Where {$_.cpu -gt 10}
Get-process |? {$_.cpu -gt 10}

#Usage Of Sort-Object Command

Help Sort-Object -ShowWindow
Get-Process | Sort-Object -Property PM -Descending
Get-Process | Sort-Object -Property CPU -Descending
Get-Process | Sort-Object -Property PM -Descending  | Select-Object -First 10

#Usage of Measure-Object Command
Help Measure-Object -ShowWindow
Get-Service | Measure-Object 

Get-ChildItem -Path C:\Users\Supercoach\Desktop| Measure-Object -Property Length -Maximum -Average -Minimum

Get-Process | Measure-Object
Get-EventLog -LogName Application -Newest 100 | Measure-Object

#Usage of Group-Object Command
Help Group-Object -ShowWindow
Get-EventLog -LogName Application -Newest 100 | Group-Object -Property EventID | Sort-Object -Property Count -Descending
Get-EventLog -LogName Application -Newest 100 | Group-Object -Property Source | Sort-Object -Property Count -Descending


#Usage of Tee-Object Command: Not very useful but its to better to know it exists
Help Tee-Object -ShowWindow
Get-Service | Tee-Object -FilePath C:\Users\Supercoach\Desktop\testtee.txt | Select Name, displayname#>