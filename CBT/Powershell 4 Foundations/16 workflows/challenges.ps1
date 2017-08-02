
#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: Workflows
#----------------------------------------------------


#I: Create a workflow that retrieves the newest 5 system event logs from multiple servers in parellel

#region

workflow Get-SystemEventLogs{
    parallel {
        Get-EventLog System -Newest 5
    }
}

Get-SystemEventLogs -PSComputerName APPNUGGET, FSNUGGET

#endregion


#II: Build on the previous workflow by accepting an $Entries parameter to accept the number of newest entries:
#    ie: Get-SystemEventLogs -Entries 10 -PSComputerName SERVER1,SERVER2

#region

workflow Get-SystemEventLogs{
    param(
        [int]$Entries
    )
    parallel {
        Get-EventLog System -Newest $Entries
    }
}

Get-SystemEventLogs -Entries 10 -PSComputerName APPNUGGET, FSNUGGET

#endregion


#III: Create a workflow that calls three scripts (or commands) and creates a checkpoint in between them.
#     Run the workflow as a job and terminate your session shortly after starting it, launch
#     a new session, view the suspended job, and resume to let it finish.
#
#  1. Create a workflow that uses two InlineScripts with a Checkpoint-Workflow in between
#  2. Run the workflow using -AsJob and terminate your session after the first InlineScript runs
#  3. Start a new session, use Get-Job to view the suspended job and then Resume-Job to complete it

#region

Workflow Test-Challenge3 {

    InlineScript { Get-Process } 

    Write-Output "Processes complete."

    Checkpoint-Workflow

    InlineScript { Get-Service }

    Write-Output "Services complete."

    InlineScript { dir c:\* -Recurse }

    Write-Output "Workflow complete!"
}

Test-Challenge3 -AsJob
Get-Job
Resume-Job -Id <id of job>

#endregion
