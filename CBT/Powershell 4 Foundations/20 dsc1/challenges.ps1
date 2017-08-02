
#---------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: DSC - Getting Started
#---------------------------------------------------------------


#I: Create a basic configuration to ensure the BITS service is running, compile an .MOF, and push it to the machine.

#region

Configuration BITSConfig {
    Param([string[]]$ComputerName = "localhost")

    Node $ComputerName 
    {

        Service BITS {
            Name = 'bits'
            StartupType = 'Automatic'
            State = 'Running'
        }
    }
}

BITSConfig -ComputerName APPNUGGET
Start-DscConfiguration BITSConfig

#endregion


#II: Stop the BITS service and check for configuration drift on the machine you applied the configuration to from above. 

#region

Get-Service BITS -ComputerName APPNUGGET | Stop-Service
Test-DscConfiguration -CimSession APPNUGGET

#endregion


#III: Create an LCM configuration for the target machine you used in previous steps, change the ConfigurationMode property
#     to ApplyandAutoCorrect, set the configuration on the target machine and stop the BITS service, check it again after
#     15 minutes (default time) to ensure the configuration was re-applied
#
#  1. 

#region


# declare configuration
Configuration LCMConfig {

    Param([string[]]$ComputerName = "localhost")

    Node $ComputerName 
    {
        # LCM resource
        LocalConfigurationManager
        {
            ConfigurationMode = "ApplyAndAutoCorrect"
        }
    }
}

# generate .MOF files
LCMConfig -ComputerName APPNUGGET

#send new settings to LCM
Set-DscLocalConfigurationManager -Path LCMConfig

#endregion
