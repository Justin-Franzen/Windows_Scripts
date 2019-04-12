#clears temp folder of a lab
$BegName = Read-Host -Prompt 'Input begining of Computer name Ex: D-A01-'
[int]$StartNummber = Read-Host -Prompt 'Input start number for compter Ex: 0'
[int]$EndNummber = Read-Host -Prompt 'Input start number for compter Ex: 30'
For ($i=$StartNummber; $i -le $EndNummber; $i++) {
    if ($i -lt 10) {
        $c='0'+$i
    } else {
        $c=$i
    }
    [string]$comp = '\\' + $BegName + $c+ "\C$\"
    
    Get-ChildItem -Path $comp+"Windows\Temp\*" -recurse -include *.log, *.tmp, *.tmp-tmp, *.txt, *.html, *.sqm , *.exe, cab_* -force | ForEach ($_) {
        try{
            remove-item $_.fullname -ErrorAction Stop
        }Catch [System.Management.Automation.ActionPreferenceStopException] {
             
        }
    }
Write-Host $BegName$c " Cleaned"
}
Write-Host "All Done!"
