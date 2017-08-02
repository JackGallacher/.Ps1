
Get-Module #loaded modules
Get-Module -ListAvailable #all modules
Get-Module | Remove-Module #unloads all modules
Get-Module

Help Test-Connection
Test-Connection localhost
Get-Module


$env:PSModulePath #module paths
$env:PSModuleAutoLoadingPreference #automatic loading preference (enabled by default, set to 'none' to disable)


# add car.psm1 to user module path (source: \\fsnugget\psv4\08 extending_shell\car.psm1)
Copy-Item -Recurse '\\fsnugget\psv4\08 extending_shell\car' 'C:\Program Files\WindowsPowerShell\Modules'
Get-Command Get-Car
Remove-Module car
Remove-Item -Recurse 'C:\Program Files\WindowsPowerShell\Modules\car'

# import module from a path outside of $env:PSModulePath
Set-ExecutionPolicy RemoteSigned
Get-Command Get-Car
Import-Module '\\fsnugget\psv4\08 extending_shell\car'
Help Get-Car