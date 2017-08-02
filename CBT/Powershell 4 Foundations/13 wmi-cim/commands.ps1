
# CIM cmdlets
Get-Command -Module CimCmdlets


# finding classes
Get-Help Get-CimClass

Get-CimClass # all classes in the default namespace (root\cimv2)
Get-CimClass -ClassName *disk*
Get-CimClass -MethodName Create


# getting data from WMI classes
Get-Help Get-CimInstance

Get-WmiObject -Class Win32_LogicalDisk
Get-CimInstance -ClassName Win32_LogicalDisk

Get-CimInstance -ClassName Win32_LogicalDisk -Property DeviceID, Name, Size, FreeSpace
Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DriveType = 3'
Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DriveType = 3' -ComputerName FSNUGGET,APPNUGGET # server side filtering
Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName FSNUGGET, APPNUGGET | Where-Object {$_.DriveType -eq 3} # client side filtering


# associations 
Get-Help Get-CimAssociatedInstance

$disk1 = Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DriveType = 3'
Get-CimAssociatedInstance $disk1
Get-CimAssociatedInstance $disk1 -ResultClassName Win32_DiskPartition

$service = Get-CimInstance Win32_Service -Filter 'Name Like "winrm%"'
Get-CimAssociatedInstance -InputObject $service -Association Win32_DependentService


# methods
$p = Get-CimClass Win32_Process
$p.CimClassMethods

$a = Get-CimInstance Win32_Process -Filter "Name Like 'power%'"
$a | Invoke-CimMethod -MethodName GetOwner

# remote serversGet-Help New-CimSessionGet-CimInstance Win32_Environment -ComputerName DCNUGGET,APPNUGGETNew-CimSession -ComputerName FSNUGGET, APPNUGGET -Name Servers -Credential NUGGETLAB\AdministratorGet-CimSessionGet-CimSession -Name Servers | Get-CimInstance Win32_Environment$so = New-CimSessionOption -Protocol Dcom$s = New-CimSession -ComputerName OLDSERVER -SessionOption $soGet-CimSession Win32_Environment -CimSession $s