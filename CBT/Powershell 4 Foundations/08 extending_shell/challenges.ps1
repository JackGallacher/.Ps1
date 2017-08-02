
#-------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: Extending the Shell
#-------------------------------------------------------------


#I: View a list of loaded modules, then a list of available modules, 
#   use the autoloading feature to load a module that is currently unloaded.

#region

Get-Module #loaded modules
Get-Module -ListAvailable #available modules
Get-Command -Module ActiveDirectory #load active directory module (requires RSAT installed)
Get-Module #shows activedirectory module loaded

#endregion


#II: Create a simple script module (.psm1), save it outside of a PSModulePath, import and load it into a session.

#region

#save as stuff.psm1 -----------------
function New-Stuff ($Name, $Description) {
    ## Create some stuff
}

Export-ModuleMember -Function 'New-*'
#------------------------------------

Import-Module <path-to-.psm1>
Get-Command New-Stuff

#endregion


#III: Download a module, add it to a $PSModulePath directory, get help on a cmdlet in the module, and view loaded modules.
#
# Download Modules from: 
# http://poshcode.org/
# https://www.powershellgallery.com/
# https://gallery.technet.microsoft.com/site/search?f%5B0%5D.Type=ProgrammingLanguage&f%5B0%5D.Value=PowerShell

#region

Copy-Item 'unzipped-module-path' 'C:\Program Files\WindowsPowerShell\Modules'
Get-Help <cmdlet-in-module>
Get-Module

#endregion