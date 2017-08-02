
# DSC cmdlets
Get-Command -Noun dsc*

#resources
Get-DscResource
Get-DscResource Service | Select -ExpandProperty properties
Get-DscResource File | Select -ExpandProperty properties

#applying a configuration
Start-DscConfiguration -Path NuggetlabConfig

#viewing deployed configurations
Get-DscConfiguration -CimSession DCNUGGET

#testing configurations (detect configuration drift!)
Test-DscConfiguration -CimSession FSNUGGET

#check LCM settings
Get-DscLocalConfigurationManager -CimSession DCNUGGET, FSNUGGET
Set-DscLocalConfigurationManager -Path LCMConfig
