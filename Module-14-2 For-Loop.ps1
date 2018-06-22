
Help about_for -ShowWindow

<#
The For statement (also known as a For loop) is a language construct you can use to create a loop that runs commands in a command block while a 
specified condition evaluates to true. 

A typical use of the For loop is to iterate an array of values and to operate on a subset of these values. In most cases, if you want to 
iterate all the values in an array, consider using a Foreach statement.
#>

for($i=1; $i -le 50; $i++)

{Write-Host $i}



for($i=50; $i -Ge 1; $i--)

{Write-Host $i}

#Excel based Opeartion
$server ='Laptop'
for($i=1; $i -le 10; $i++)

{Restart-Computer $server}

