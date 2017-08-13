Function Get-LogicalDiskInformation{  
<#
.SYNOPSIS
Returns capcity information about the logical disks on a system.

.DESCRIPTION
Returns a custom view which shows the 'Volume ID', 'Volume Name', 'File System', 'Disk Size (GB)', 'Free Space (GB)' and 'Free Space (%)' of all the logical disks on the current system.

.EXAMPLE
Get-LogicalDiskInformation   
#>

    $CustomView = @{Expression = {$_.DeviceID}; Label = "Volume ID"},
                  @{Expression = {$_.VolumeName}; Label = "Volume Name"},
                  @{Expression = {$_.FileSystem}; Label = "File System"},
                  @{Expression = {[math]::Round($_.Size / 1GB, 1)}; Label = "Disk Size (GB)"},
                  @{Expression = {[math]::Round($_.FreeSpace / 1GB, 1)}; Label = "Free Space (Gb)"},
                  @{Expression = {[math]::Round(($_.FreeSpace / $_.Size) * 100, 1)}; Label = "Free Space (%)"}

    $DiskInformation = Get-WmiObject Win32_LogicalDisk    
    $DiskInformation | Format-Table $CustomView -AutoSize   
}