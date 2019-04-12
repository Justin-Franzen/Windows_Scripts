#Update Print severs script
#Updates prints that have the same name on both servers
function Pause{
   Read-Host 'Press Enter to continue…' | Out-Null
}

$Printers = Get-WmiObject -Class Win32_Printer
ForEach ($Printer in $Printers) {

If ($Printer.SystemName -like "\\Old-PrintServer1") {
(New-Object -ComObject WScript.Network).RemovePrinterConnection($($Printer.Name))
Echo $Printer.Name Removed
$tempPrinterName = $Printer.Name
$tempPrinterName = "\\New-PrintServer1" + $tempPrinterName.Remove(0,13)
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($tempPrinterName)
Echo $tempPrinterName added
}

If ($Printer.SystemName -like "\\Old-PrintServer2") {
(New-Object -ComObject WScript.Network).RemovePrinterConnection($($Printer.Name))
Echo $Printer.Name Removed
$tempPrinterName = $Printer.Name
$tempPrinterName = "\\New-PrintServer2" + $tempPrinterName.Remove(0,13)
(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($tempPrinterName)
Echo $tempPrinterName added
}

}
Pause

