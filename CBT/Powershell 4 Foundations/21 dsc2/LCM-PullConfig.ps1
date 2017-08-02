Configuration LCMPullConfig
{
    param
    (
        [string[]]$ComputerName,
        [string]$guid
    )

    Node $ComputerName
    {
        LocalConfigurationManager
        {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationID = $guid
            RefreshMode = "Pull"
            DownloadManagerName = "WebDownloadManager"
            DownloadManagerCustomData = 
                @{
                    ServerUrl = "http://APPNUGGET:8080/PSDSCPullServer.svc"
                    AllowUnsecureConnection = "true"
                }
        }
    }
}

LCMPullConfig -ComputerName DCNUGGET,FSNUGGET -guid '84ee1381-44d6-4702-978d-716d9ca869dc' #.MOF guid
Set-DSCLocalConfigurationManager LCMPullConfig
Get-DscLocalConfigurationManager -CimSession DCNUGGET,FSNUGGET