#Get Fress disck space for a lab
"" > $PSScriptRoot\Space.txt
$BegName = Read-Host -Prompt 'Input begining of Computer name Ex: D-A01-'
[int]$StartNummber = Read-Host -Prompt 'Input start number for compter Ex: 0'
[int]$EndNummber = Read-Host -Prompt 'Input start number for compter Ex: 30'
For ($i=$StartNummber; $i -le $EndNummber; $i++) {
    if ($i -lt 10) {
        $c='0'+$i
    } else {
        $c=$i
    }
    $comp = $BegName + $c

    $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $comp -Filter "DeviceID='C:'" |
    Select-Object Size,FreeSpace
   $comp + " Free space: " + ($disk.FreeSpace / 1073741824) >> $PSScriptRoot\Space.txt
}