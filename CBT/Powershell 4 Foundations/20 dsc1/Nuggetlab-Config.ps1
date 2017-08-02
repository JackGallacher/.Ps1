
# declare configuration
Configuration NuggetlabConfig {
 
    # parameters
    Param([string[]]$ComputerName = "localhost")

    # target node
    Node $ComputerName {

        # file resource
        File PSInstallations {
            Ensure          = "Present"
            SourcePath      = "\\fsnugget\psv4\installs"
            DestinationPath = "c:\installs"
            Type            = "Directory"
            Recurse         = $true
        }

        # service resource
        Service WindowsUpdate {
            Name = 'wuauserv'
            StartupType = 'Automatic'
            State = 'Running'
        }

        # windows feature resource
        WindowsFeature WindowsBackup {
            Name = 'Windows-Server-Backup'
            IncludeAllSubFeature = $true
            Ensure = 'Present'
        }
        
    }
}


# generate .mof files
NuggetlabConfig -ComputerName DCNUGGET, FSNUGGET
