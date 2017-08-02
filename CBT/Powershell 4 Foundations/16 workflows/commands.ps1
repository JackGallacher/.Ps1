
# basic workflow stuff
workflow Get-MyFirstWorkflow{
    param(
        [String]$You
    )

    "Hello $You!"
}

Get-Command *workflow*
Get-Help Get-MyFirstWorkflow

Get-MyFirstWorkflow -You "me"


# parallel flows
Workflow Get-SystemStuff {
$a = Get-Service

    parallel {
        Get-Service win*
	    Get-Process p*
	    Get-EventLog System -Newest 10 -EntryType Error
    }
}

Get-SystemStuff -PSComputerName DCNUGGET,APPNUGGET,FSNUGGET


WorkFlow Copy-Files {
 
    Param (
        [String]$Source,
        [String]$Destination
    )
 
    $files = Get-ChildItem $Source

    Foreach -parallel ($file in $files) { #parallel
        Copy-Item -Path $file.FullName -Destination $Destination
        Write-Output "$file copied."
    }

    Write-Output "Copy-Files complete!"
}

New-Item c:\installs -ItemType Directory
Copy-Files \\fsnugget\psv4\installs c:\installs


# sequential flows
Workflow Test-SWF {    
    parallel {        
        
        Get-Service a*

        sequence {
            Get-Process c*
            Get-Process p*
            Get-Process w*
        }

        Get-Service b*
           
    }
}

Test-SWF


# checkpoints
Workflow Copy-FilesCheck{
    Param (
        [String]$Source,
        [String]$Destination
    )

    $files = Get-ChildItem $Source

    ForEach ($File in $Files){ #sequential
        Copy-Item -Path $file.FullName -Destination $Destination -Force
        Write-Output "$file copied."
        
        Checkpoint-Workflow
        Start-Sleep 2
    }

    Write-Output "All files copied."
}

Copy-FilesCheck \\fsnugget\psv4\installs c:\installs -AsJob
Stop-Computer FSNUGGET -Force