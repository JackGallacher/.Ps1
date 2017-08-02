#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: WMI & CIM
#----------------------------------------------------

#Task 1 - Use WMI Explorer to find the class for working with BIOS. Use the CIM cmdlets 
#in PowerShell to retrieve ALL of the instances properties
Get-CimInstance Win32_BIOS | Format-List *

#Task 2 - Use the PowerShell CIM cmdlets to query for a physical drive and change the label of the volume.
#1. Store a drive in a variable using Get-CimInstance
#2. Pipe the variable to Set-CimInstance and set the VolumeName property
#3. Use the Passthru switch to view the results of the operation
$c = Get-CimInstance -ClassName win32_Logicaldisk -Filter "DeviceID = 'c:'"
$c | Set-CimInstance -Property @{VolumeName='System Disk'} –PassThru
