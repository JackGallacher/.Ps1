#---------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: DSC - Getting Started
#---------------------------------------------------------------

#Task 1 - Create a basic configuration to ensure the BITS service is running, compile an .MOF, and push it to the machine.
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

#Task 2 - Stop the BITS service and check for configuration drift on the machine you applied the configuration to from above.
Get-Service BITS -ComputerName APPNUGGET | Stop-Service
Test-DscConfiguration -CimSession APPNUGGET

#Task 3 - Create an LCM configuration for the target machine you used in previous steps, change the ConfigurationMode property
#to ApplyandAutoCorrect, set the configuration on the target machine and stop the BITS service, check it again after
#15 minutes (default time) to ensure the configuration was re-applied
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
#Generate .MOF files
LCMConfig -ComputerName APPNUGGET

#Send new settings to LCM
Set-DscLocalConfigurationManager -Path LCMConfig