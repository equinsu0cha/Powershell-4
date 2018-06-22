 
  Help About_do -ShowWindow
 
 


 $val = 0
 
 while($val -ne 3)
        {
            $val++
            Write-Host $val
        }


   <#   A Do-While loop is a variety of the While loop. In a Do-While loop, the
        condition is evaluated after the script block has run. As in a While loop,
        the script block is repeated as long as the condition evaluates to true.
   #>


    $a=1

    do{
      
        Write-Host $a;
         $a++
        }
        while ($a -lt 10)


#Sql Jobs

#Execute Job
#Monitor Job



##$a =1
do{Write-Host $a;
         $a++}
Until ($a -lt 10)


$b++

$b