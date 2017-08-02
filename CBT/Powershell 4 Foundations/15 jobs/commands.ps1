
# background jobs
Get-Command -Noun job

Start-Job -Name RecurseSystemDrive -ScriptBlock {Get-ChildItem $env:systemdrive\* -Recurse}
Start-Job -Name ThisIsBad -ScriptBlock {Test-Connection -ComputerName BAD, NUGGET}

Get-Job

Stop-Job -Name RecurseSystemDrive
Receive-Job –Name RecurseSystemDrive –Keep
Receive-Job -Name ThisIsBad
Get-Job | Remove-Job


# remote jobs
Get-Command -ParameterName AsJob

Invoke-Command -ScriptBlock {Get-Eventlog System -Newest 10 -EntryType Error} -ComputerName FSNUGGET,APPNUGGET,DCNUGGET -AsJob
Get-Job -IncludeChildJob
Receive-Job -Id 8


# scheduled jobs
Get-Command -Module PSScheduledJob

$t = New-JobTrigger -Daily -At 3AM
$o = New-ScheduledJobOption -WakeToRun -StartIfOnBattery
Register-ScheduledJob -Name GetNewestHelp -ScriptBlock {Save-Help -DestinationPath \\fsnugget\psv4\help} -Trigger $t -ScheduledJobOption $o
 
Get-ScheduledJob
Get-ScheduledJobOption -Name GetNewestHelp
Get-ScheduledJobOption -Name GetNewestHelp | Set-ScheduledJobOption -StartIfIdle -Passthru

Start-Job -DefinitionName GetNewestHelp
Get-Job
Receive-Job GetWServices

Get-ScheduledJob | Unregister-ScheduledJob