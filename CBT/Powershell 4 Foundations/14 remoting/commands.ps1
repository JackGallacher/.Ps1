
# enable remoting (winrm)
Help Enable-PSRemoting

Enable-PSRemoting
Disable-PSRemoting

Get-PSSessionConfiguration


# interactive 1:1 remoting
Enter-PSSession FSNUGGET
dir
Exit-PSSession


# 1:many remoting
Help Invoke-Command
 
Invoke-Command -ScriptBlock {Get-WindowsFeature web-server} -ComputerName DCNUGGET,APPNUGGET,FSNUGGET
Invoke-Command -FilePath \\fsnugget\psv4\scripts\create-logdir.ps1 -ComputerName DCNUGGET,APPNUGGET,FSNUGGET

Invoke-Command -ScriptBlock {$w = Get-Service win*} -ComputerName APPNUGGET,FSNUGGET
Invoke-Command -ScriptBlock {$w.count} -ComputerName APPNUGGET,FSNUGGET


# persistent session
$dc = New-PSSession DCNUGGET
Get-PSSession
Enter-PSSession -Session $dc
$logs = Get-EventLog -LogName System -Newest 10
Exit-PSSession
Get-PSSession
Disconnect-PSSession
$newdc = Get-PSSession -ComputerName DCNUGGET | Connect-PSSession
Invoke-Command -ScriptBlock { $logs } -Session $newdc


# implicit remoting
Invoke-Command -ScriptBlock {Install-WindowsFeature web-server} -ComputerName APPNUGGET
$app = New-PSSession APPNUGGET
Import-Module WebAdministration -PSSession $app
Help Get-WebSite
Get-WebSite
Get-PSSession | Remove-PSSession
Help Get-WebSite
Get-WebSite

