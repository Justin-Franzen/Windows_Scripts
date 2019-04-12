#Creates a csv file with 
#Computer, Total disk space, Free disk space, Percentage free
#Run against whole domain (Name starts with "D-")
Do{$filePath = Read-Host -Prompt 'Enter the output file name'}
while ($filePath -eq "")
$filePath = $filePath + ".csv"
$allComputers = Get-ADComputer -Filter 'Name -like "D-*"'


#"Computer", "Total disk space", "Free disk space", "Percentage free"| Export-Csv -Path $filePath
 Remove-Item $filePath 

foreach($comp in $allComputers){
    if (Test-Connection -Computername $comp.Name -BufferSize 16 -Count 1 -Quiet) {
        $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $comp.Name -Filter "DeviceID='C:'" |
        Select-Object Size,FreeSpace
        $freeSpace = [math]::Round(($disk.FreeSpace / 1073741824),2)
        $totalDiskSpace =[math]::Round(($disk.Size / 1073741824),2)   
        $name = $comp.Name 

        $details = New-Object PSObject -Property ([ordered] @{            
                Computer       =  $name
                TotalDiskSpace =  $totalDiskSpace              
                FreeDiskSpace  =  $freeSpace
                PercentageFree   = ([math]::Round(($freeSpace /  $totalDiskSpace ),4))*100
        } )
        Write-Host($details)


        $details | Export-Csv -Path $filePath -Append
     } 
}
