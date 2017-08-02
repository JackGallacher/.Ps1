#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: Jobs
#----------------------------------------------------

#Task 1 - Start a background job on your local machine to retrieve the system event log, 
#   check the job status, and when finished retrieve the results by ID.
Start-Job -ScriptBlock {Get-Eventlog System}
Get-Job
Receive-Job -Id 25

#Task 2 - Start a remote job across multiple machine to retrieve the system event log, 
#    check the job status (including child jobs), and when finished retrieve the results, 
#    use a variable to store and work with the job. Clean up by removing all jobs.
$job = Invoke-Command -ScriptBlock {Get-Eventlog System} -ComputerName FSNUGGET,APPNUGGET,DCNUGGET -AsJob
Get-Job -IncludeChildJob
Receive-Job -Job $Job
Get-Job | Remove-Job

#Task 3 - Schedule a job to retrieve security event logs with an eventtype of error
#     daily at 12am. Run the scheduled job manually, view results,
#     and unregister the scheduled job.
#
#  1. Use Get-EventLog to retrieve security event logs for the error type
#  2. Register a scheduled job to perform the above task daily @ 12am
#  3. Start the job manually using Start-Job and the -DefinitionName parameter
#  4. View the results using Receieve-Job once complete
#  5. Remove the scheduled job using Unregister-ScheduledJob
Get-ScheduledJob | Unregister-ScheduledJob
Register-ScheduledJob -Name GetSecurityErrorEvents -ScriptBlock {Get-EventLog Security -EventType Error} -Trigger (New-JobTrigger -Daily -At 12am)
Start-Job -DefinitionName GetSecurityErrorEvents
Receive-Job -Id <ID from above>
Unregister-ScheduledJob -Name GetSecurityErrorEvents