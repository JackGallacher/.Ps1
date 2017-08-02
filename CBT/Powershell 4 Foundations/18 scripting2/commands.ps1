
#region variables
$a = 10
$a | gm

[int]$a = 'test'
[string] $a = 'test'
$a

[string]$date = Get-Date
$date.DayOfWeek

[datetime]$date = Get-Date
$date.DayOfWeek


gcm -noun variable

New-Variable -Name dirs -Value (Get-ChildItem c:\ -Directory) -Option ReadOnly
$dirs
$dirs = Get-ChildItem c:\windows -Directory

#.automatic variables
Get-ChildItem variable:

#.environment variables
Get-ChildItem env:
#endregion


#region conditions

#.if..else
$num = 100
if ($num -gt 100) 
{
  "$num is larger than 100"
} 
else
{
  "$num is less than or equal to 100"
}

#.if..else..elseif
if ($num -gt 100) 
{
  "$num is larger than 100"
} 
elseif ($num -eq 100) 
{
  "$num is exactly 100"
} 
else 
{
  "$num is less than 100"
}

$val = Read-Host 'What size milkshake would you like?'
if ($val -eq 'small')
{ 
  '- Small it is.'
}
elseif ($val -eq 'medium')
{ 
  '- Medium coming right up.'
}
elseif ($val -eq 'large')
{ 
  '- Living large!'
}
elseif ($val -eq 'xlarge')
{ 
  '- Wow, that is one big milkshake!'
}
else
{
  '- That is not a size we offer, sorry.'
}

#.switch
[int]$val = Read-Host 'What size milkshake would you like? (1=small, 2=medium, 3=large, 4=xlarge)'
switch ($val)
{
  1 { 'Small' }
  2 { 'Medium' }
  3 { 'Large' }
  4 { 'XLarge' }
  default { 'That size is not available. :(' }
}

#endregion


#region loops

#.foreach-object
1..10 | Foreach-Object { "Executing $_" }

# foreach loop
$files = Get-ChildItem c:\
foreach ($file in $files) { 
    $file.Name
}

#.foreach loop w/ switch
$disks = Get-CimInstance Win32_LogicalDisk

Foreach ($disk in $disks) {
    Switch ($disk.DriveType) {
        1 { $disk.DeviceID + " Unknown" } 
        2 { $disk.DeviceID + " Floppy or Removable Drive" } 
        3 { $disk.DeviceID + " Hard Drive" } 
        4 { $disk.DeviceID + " Network Drive" } 
        5 { $disk.DeviceID + " CD" } 
        6 { $disk.DeviceID + " RAM Disk" } 
    }
}

#.do while
do {
  $input = Read-Host "Guess the magic number to escape. Muwahahahaha!"
} while (!($input -eq 1337))

Write-Host "Whoa.. you got lucky!"

#.for
for($i=1; $i -le 10; $i++){
  Write-Host $i
}

#endregion


#region error handling

#.error variable & error action common parameters
Get-Content \\fsnugget\psv4\files\servers-oops.txt -ErrorVariable uhoh
$uhoh

Get-Content \\fsnugget\psv4\files\servers-oops.txt -ErrorAction Continue

#.try..catch..finally
help about_Try_Catch_Finally

try {
    Write-Host 'Starting some code..'

    $servers = Get-Content \\fsnugget\psv4\files\servers-oops.txt -ErrorAction Stop
   
    Write-Host 'Can you hear me!?'
}
catch [System.Management.Automation.ItemNotFoundException]{
    Write-Host 'Check the path to your file.'
}
catch {
    Write-Host 'Some other error'
}
finally{
    Write-Host '...and have a nice day!'
}

#endregion


#region functions
help about_Functions

function Get-ComputerInfo {
    param ([array]$ComputerName)

    Invoke-Command { Get-Service | Where-Object Status -eq Running } -ComputerName $ComputerName
    Invoke-Command { Get-Process | Where-Object CPU -gt 1 } -ComputerName $ComputerName
}

Get-ComputerInfo -ComputerName DCNUGGET,APPNUGGET


function Send-GmailMessage {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Recipient,
        [String]$From = "admin@nuggetlab.com",
        [String]$Subject,
        [String]$Body
    )

    #splatting parameters
    $param = @{
        SmtpServer = 'smtp.gmail.com'
        Port = 587
        UseSsl = $true
        Credential = (Get-Credential)
        From = $From
        To = $Recipient
        Subject = $Subject
        Body = $Body
    }

    
    Send-MailMessage @param

}

Send-GmailMessage -Recipient garth@nuggetlab.com -Subject 'Test from function' -Body 'Hello from PowerShell 4 Foundations!'

#endregion

