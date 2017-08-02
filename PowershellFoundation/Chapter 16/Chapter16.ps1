#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: Workflows
#----------------------------------------------------

#Task 1 - Create a workflow that retrieves the newest 5 system event logs from multiple servers in parellel
workflow getEventLogs{
    parallel{
        Get-EventLog System -Newest 5
    }

}
getEventLogs

#Task 2 - Build on the previous workflow by accepting an $Entries parameter to accept the number of newest entries:
#Get-SystemEventLogs -Entries 10 -PSComputerName SERVER1,SERVER2
workflow getEventLogs{
    param(
        [int]$Entries
    )
    
    parallel{
        Get-EventLog System -Newest $Entries
    }

}
getEventLogs -Entries 3

#Task 3 - Create a workflow that calls three scripts (or commands) and creates a checkpoint in between them.
#Run the workflow as a job and terminate your session shortly after starting it, launch
#a new session, view the suspended job, and resume to let it finish.
#  1. Create a workflow that uses two InlineScripts with a Checkpoint-Workflow in between
#  2. Run the workflow using -AsJob and terminate your session after the first InlineScript runs
#  3. Start a new session, use Get-Job to view the suspended job and then Resume-Job to complete it
workflow checkpointTest{
    param(
        [String]$command1 = 'Get-Service',
        [String]$command2 = 'Get-Process',
        [String]$command3 = 'Get-Command'
    )
    InlineScript{
        $command1
    }
    Write-Output 'command1 complete'
    Checkpoint-Workflow

    InlineScript{
        $command2
    }
    Write-Output 'command2 complete'
    Checkpoint-Workflow

    InlineScript{
        $command3
    }
    Write-Output 'command3 complete'
    Checkpoint-Workflow
}
checkpointTest -AsJob