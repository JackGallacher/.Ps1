Get-Service | Stop-Service -whatif

# byValue
Get-Service | Get-Member
Get-Help Stop-Service -Full

Get-Service | Sort-Object DisplayName
Get-Help Sort-Object -Full

# byPropertyName
Get-Process notepad | Stop-Process
"notepad" | Stop-Process

$np = new-object PSObject
$np | Add-Member -MemberType NoteProperty -Name "Name" -Value "notepad"
$np | Add-Member -MemberType NoteProperty -Name "Time" -Value (Get-Date)
$np | stop-process


get-service | stop-process -whatif

# custom properties
#name,username,title,company
#gschulte,gschulte,trainer,cbt nuggets
#starlord,starlord,starlord...man,guardians
#jsnover,jsnover,the powershell guy,microsoft

Import-Csv users.csv | New-ADUser -whatif
Import-Csv users.csv | select-object *,@{n='samaccountname';e={$_.username}} | New-ADUser

Get-ADUser -Filter *

# parenthetical Commands
#computername
#dcnugget
#fsnugget
#appnugget

Get-Content .\servers.txt | Get-Service
Import-Csv .\servers.csv | Get-Service

get-help get-wmiobject -Parameter Computername
Import-Csv .\servers.csv | Get-WmiObject Win32_OperatingSystem

Get-WmiObject Win32_OperatingSystem -ComputerName (Get-Content .\servers.txt)
Get-WmiObject Win32_OperatingSystem -ComputerName (Get-ADComputer -filter * | select-object -expandproperty name)