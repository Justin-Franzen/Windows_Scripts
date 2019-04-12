#I created this so I could drag Powershell Files on to it and haved them signed
Add-Type -Name win -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);' -Namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle,0) #hide powershell prompt 

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form1 = New-Object System.Windows.Forms.Form
$Form1.ClientSize = "500, 500"
$Form1.TopMost = $true

$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Anchor = "Top,Bottom,Left,Right"
$TextBox1.Location = "12, 12"
$TextBox1.Multiline = $true
$TextBox1.ScrollBars = "Both"
$TextBox1.Size = "475, 475"
$TextBox1.AllowDrop = $true
$TextBox1.add_DragEnter({FNprocess($_)})

$Form1.Controls.Add($TextBox1)

$cert=(dir cert:currentuser\my\ -CodeSigningCert)

function FNprocess( $object ){
  foreach ($file in $object.Data.GetFileDropList()){
    $TextBox1.AppendText($file+[char]13+[char]10) #Print file path
	
	Set-AuthenticodeSignature $file $cert -TimestampServer http://timestamp.comodoca.com/authenticode #Sign file
	if($?){ #check staus on last command
		$TextBox1.AppendText("Signed Successfully!"+[char]13+[char]10) 
	}else{
		$TextBox1.AppendText("Error Signing"+[char]13+[char]10)
	}
  }
}

[System.Windows.Forms.Application]::Run($Form1)
