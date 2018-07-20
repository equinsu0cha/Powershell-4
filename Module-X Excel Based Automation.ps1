$ErrorActionPreference = 


$row = 1
$column= 1
$EXCEL = New-Object -ComObject Excel.Application
$EXCEL.visible = $true
#$WORKBOOK = $EXCEL.workbooks.open("D:\MYEXCEL.xlsx")
$WORKBOOK = $EXCEL.workbooks.Add()
#$WORKSHEETS = $WORKBOOK.worksheets
$WORKSHEET = $WORKBOOK.worksheets.Item(1)

$WORKSHEET.cells.item($row,$column)="ProcessName"
$WORKSHEET.cells.item($row,$column+1)="ID"
$WORKSHEET.cells.item($row,$column+2)="CPU"
$WORKSHEET.cells.item($row,$column+3)="PM"

$process = Get-Process

for ($row= 2; $row -le 100;$row++){
    for ($i= 0; $i -le 100;$i++){
 #foreach($procs in $process){
    $WORKSHEET.cells.item($row,$column)=$Process[$i].Name
    $WORKSHEET.cells.item($row,$column+1)=$Process[$i].ID
    $WORKSHEET.cells.item($row,$column+2)=$Process[$i].CPU
    $WORKSHEET.cells.item($row,$column+3)=$Process[$i].PM
    $row++
    }
}
$WORKBOOK.SaveAs("D:\MYEXCEL.xlsx")

$EXCEL.workbooks.Close()
$EXCEL.Application.Quit()


#For Reading Excel Sheet content

$row = 1
$column= 1
$EXCEL = New-Object -ComObject Excel.Application
$EXCEL.visible = $true
$WORKBOOK = $EXCEL.workbooks.open("D:\MYEXCEL.xlsx")
$WORKSHEET = $WORKBOOK.worksheets.Item(1)

for($row =1; $row -le 100 ;$row++){
$WORKSHEET.cells.item($row,$column).value2
$WORKSHEET.cells.item($row,$column+1).value2
$WORKSHEET.cells.item($row,$column+2).value2
$WORKSHEET.cells.item($row,$column+3).value2
}