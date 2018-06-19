##Array can be defined as the data structures that are designed to store collections of Items
# Thes Items can be of Different types
Help About_arrays -ShowWindow

$a= @()


@(1,22,344,56,29,80)
$a=@(1,22,344,56,29,80)
$a[-2]
$a[$i]

$B= 1,22,344,56,29,80

$b[-2]

$text = "Pune","Mumbai", "Nasik"

,$text | Get-Member
$text[1]= "Nagpur"
$text


$text = "Pune","Mumbai", "Nasik", 12,1543,6178
$text[2]

#Casting
[INT32[]]$x= 12,456,55,77,898

$x ="Pune"
$x += 100

[String[]]$Text = "Pune","Mumbai", "Nasik"

$Text +="Nagpur"
$Text += 10
$text.Clear()
$text = $null

[Datetime]$date= Get-Date
$date += "Test"

$date =12 


[int32[]]$c =@( 1,22,344,56,29,80)
$c.Length

$c ="Powershell"
$b = 3..9

$d = 'Test1'..'Test10'

for ($i = 1; $i -le 10;$i++){
$servername = "Test" + $I
$servername #| out-file C:\Users\Supercoach\Desktop\servers.txt
}
# when we dont cast the array as INT or String or charater or Float then Powershell  
#creates each array as an Object array.
#We can find that with GetType() Method
$text = "Pune","Mumbai", "Nasik"
,$text | Get-Member
$Text.GetType()
$c.GetType()

[int32[]]

$c = 1,22,344,56,29,80

,$c | get-member

$c.GetType()
$date.GetType()

$Proc = Get-Process

$proc[-1]
$Proc[-5]
[Array]$service = Get-Service
$service[0]

$service.Length

$Proc[-1]

## Blank Array is denoted by 

@()

$Proc =@(Get-Process Notepad)

$proc.GetType()


##Not An array
$process = Get-Process Notepad

$process.GetType()


$Proces =@(Get-Process)

$c[-1]
$c[-2]
## Accessing the contents of Array
$Proces[1]
$Proces[4]
$Proces[5]
$Proces[-3]
$Proces[-4]
$Proces[-1]

$Proces[1..4]

$Proces[-1..-4]

#To find the objects and methods of Array

Get-Member -InputObject $proc

,$proc | Get-Member


##Manipulating an Array

$text = "Pune","Mumbai", "Nasik"
,$text | Get-Member
$text+= "Nagpur"
$text.Remove(0)
$servers= Get-Content C:\temp\Servers.txt
$servers[0]
#Notepad C:\Temp\Serverlist.txt


[int32[]]$c = 1,22,344,56,29,80


$C.SetValue(809,1)

#1 is the index and 809 is the value to be changed

$c+= 300,400

$c = $null


$array = @()


$array += "Server1 Is Rebooted Successfully"
$array += "Server2 Is Rebooted Successfully"
$array += "Server3 Is Rebooted Successfully"
$array += "Server4 Is Rebooted Successfully"

$array.GetType()

$M = "TYest"
$M += "Value"
$M += "Property"


$M