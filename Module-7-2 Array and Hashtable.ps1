Help about_Hash_Tables -ShowWindow

#Begin an Hashtable with an at Sign (@).

#Enclose the Hashtable in Braces ({ }).

#Enter one or more key-Value pair for the content of hash table.

#Use Equal to sign (=) to seperate each key from its value.

#Use Semicolon (;) to seperate the key value pair.

#Keys that contains Spaces must be enclosed in the Quotation marks. Also values must be a valid powershel expression.
#String must appear in the quotation marks, even if the dont include the Spaces.

#To Manage the hash table save it in variable.

#[Ordered] Key word must be placed when you want to define an ordered Hashtable.



#To Create Empty hash table

$hash = @{}


$hash = @{Number =1; 
          Shape ="Square";
          Color ="Red"}


          $hash | Get-Member

$hash = [ordered]@{Number =1; Shape ="Square"; Color ="Red"}


$hashtable = [ordered]@{Name="Jeff"; Title="MVP";Computername ="$env:COMPUTERNAME"}

$hashtable | Get-Member

$hashtable.Keys
$hashtable.Values
$hashtable.clear()

$hashtable.add("Location","Chicago")
$hashtable.add("Company","Cosmos")
$hashtable.add("Office","Green Field")

$hashtable.Keys
$hashtable.Values
$hashtable.company 
$hashtable.company ="Martian"
$hashtable.Remove("Office")
$hashtable.Clear()
$hashtable

#You cant cast the variable as Orderd

$hash = [ordered]@{Number =1; Shape ="Square"; Color ="Red"}

#  Displaying the content of hash table

$Hash

$hash | gm

# Properties in Hash table

$hash.keys

$hash.Values

$hash.Color

$hash.number

# Methods in hash Table

$hash.add("Visibility","Opaque")


$hash.Remove("Visibility")

##Assigning .Net type of Object to the Hashtable

$p = @{"Powershell"=(Get-Process Powershell); "Notepad" = (Get-Process Notepad )}


$p.Powershell

$p.keys

$p.keys | foreach{$p.$_.Handles}


##You cant sort the hash table hence to mitigate this challange there is method called GetEnumerator which enumerates the Keys and Values and then we can use Sort command to it
$hashtable.GetEnumerator() | Sort-Object -Property Value -Descending

$hash


#Creating the Object from Hash Table
#$NewObject = New-Object -TypeName Psobject -Property $hashtable
#$NewObject.Color



$NewObject | gm
$NewObject.Company






$hostname = Hostname
$ipaddress = Get-NetIPAddress -InterfaceIndex 11 -AddressFamily ipv4 | select -ExpandProperty Ipaddress 
$Serialnumber = Gwmi win32_Bios | select -expand SerialNumber
#$OS= Gwmi win32_operatingsystem | Select -ExpandProperty Version
$os =Gwmi win32_operatingsystem | select Version

$systeminfo = @{
    Hostname ="$hostname"; Ipaddress ="$ipaddress"; SerialNumber= "$Serialnumber";
    OS = $os.Version

}
$systeminfo




