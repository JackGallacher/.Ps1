# get-member
help Get-Member
Get-Service | Get-Member

# properties
dir | gm
dir -Directory | gm
dir -Directory | Select Name, CreationTime, FullName
(dir -Directory).FullName
(dir desk* -Directory).CreateSubdirectory('test')

# methods
$today = Get-Date
$today | gm
$today.DayOfYear
$today.DayOfWeek
$today.AddDays(30)
$today.AddMonths(6)
(Get-Date).AddYears(10)

# static methods
[math] | gm
[math] | gm -static
[math]::pi
[math]::min(100, 10000)



# *-object cmdlets
Get-Command -Noun object


# where-object
Get-Service | Where-Object Status -eq "Running"
Get-Service | Where-Object {$_.Status -eq "Running"}
Get-Service | Where-Object {$_.Status -eq "Running" -and $_.CanStop}


# select-object
Get-Service | Select-Object *
Get-Service | Select-Object Name, Status, MachineName, ServiceType -First 5 -Unique
Get-ChildItem \\fsnugget\psv4\installs | Select-Object Name, Length, @{Name="MBs";Expression={$_.Length / 1Mb}}


# sort-object
Get-Childitem | Sort-Object Length -Descending -CaseSensitive


# foreach-Object
1,2,3,4 | ForEach-Object {$_ * 100}


dir c:\*.exe -recurse | where {$_.CreationTime.Year -eq (Get-Date).Year} | 
    % -Begin {Get-Date} `
      -Process {Out-File exe-log.txt -Append -InputObject $_.FullName} `
      -End {Get-Date}


# using -passthru
Get-ChildItem *.txt -ReadOnly -Recurse | Rename-Item -NewName {$_.BaseName + "-ro.txt"} -PassThru