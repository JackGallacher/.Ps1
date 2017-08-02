
# Extending Objects

# select-object
$os = Get-WmiObject Win32_OperatingSystem
$os | select PSComputername, Caption, @{Name="IPv4";Expression={(Get-NetIPAddress -AddressFamily IPv4)}}

# add-member
$os | Add-Member -MemberType ScriptProperty -Name IPv4 -Value {(Get-NetIPAddress -AddressFamily IPv4)}
$os | gm
$os | select PSComputerName, Caption, IPv4

$os | Add-Member -MemberType AliasProperty -Name OperatingSystem -Value Caption
$os | Add-Member -MemberType AliasProperty -Name ServicePack -Value ServicePackMajorVersion
$os | Add-Member -MemberType NoteProperty -Name Department -Value 'PSOps'
$os | gm
$os | select PSComputerName, IPv4, OperatingSystem, ServicePack, Department

$os | Add-Member -MemberType ScriptMethod `                 -Name Ping `                 -Value {Test-Connection -ComputerName $this.PSComputername} -Force                   #$this = object being extended, used over $_ when defining scriptmethod/scriptproperty

$os.Ping()


# new-object
$pc = New-Object PSObject -Property @{
  User = $env:USERNAME.ToLower()
  Machine = $env:COMPUTERNAME.ToUpper()
  IPv4 = (Get-NetIPAddress -AddressFamily IPv4)
  OS = (Get-CimInstance Win32_OperatingSystem).Caption
  SP = (Get-CimInstance Win32_OperatingSystem).ServicePackMajorVersion
}

$pc | gm

$pc | Add-Member -MemberType NoteProperty -Name Department -Value 'PSOps'
$svc = {Get-Service | Where {$_.status -eq "Running"}}
$log = {Get-Eventlog -LogName "System" -Newest 10}
$pc | Add-Member -MemberType ScriptMethod -Name GetRunningServices -Value $svc
$pc | Add-Member -MemberType ScriptMethod -Name GetSystemLogs -Value $log
$pc | Add-Member -MemberType PropertySet -Name Stuff -Value Machine, OS, SP

$pc | gm
$pc | Select Stuff
$pc.GetRunningServices()


# Extending Types
Update-TypeData -TypeName System.DateTime `
                -MemberType ScriptProperty `
                -MemberName Quarter `
                -Value {if ($this.Month -in @(1,2,3)) {"Q1"}  `
                        elseif ($this.Month -in @(4,5,6)) {"Q2"} `
                        elseif ($this.Month -in @(7,8,9)) {"Q3"} `
                        else {"Q4"}}

Get-Date | Get-Member
(Get-Date).Quarter