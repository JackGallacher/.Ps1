
# declare configuration
Configuration LCMConfig {

    # parameters
    Param([string[]]$ComputerName = "localhost")

    # target node
    Node $ComputerName 
    {
        # LCM resource
        LocalConfigurationManager
        {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 15
        }
    }
}

# generate .MOF files
LCMConfig -ComputerName DCNUGGET, FSNUGGET