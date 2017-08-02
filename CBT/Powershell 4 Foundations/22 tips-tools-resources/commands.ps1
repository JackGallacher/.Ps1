
# create a profile script
help about_Profiles

$profile.AllUsersAllHosts
Test-Path $profile.AllUsersAllHosts
New-Item -Path $profile.AllUsersAllHosts -Type File -Force

Start $profile.AllUsersAllHosts


# profile script example
$shell = $Host.UI.RawUI

$size = $Shell.WindowSize
$size.width=120
$size.height=35
$shell.WindowSize = $size

$size = $Shell.BufferSize
$size.width=120
$size.height=3000
$shell.BufferSize = $size

$shell.WindowTitle = "PowerShell Ninja"

Set-Location c:\

Clear-Host

$cmdlet = (Get-Command -Module Microsoft*,PS* | Get-Random).Name
$about = (Get-Random -Input (Get-Help about*)).Name

Write-Host ""
Write-Host "## Welcome to another fabulous session!"
Write-Host "## ------------------------------------"
Write-Host "##     Your random cmdlet: $cmdlet     "
Write-Host "##     Your random _about: $about      "
Write-Host "## ------------------------------------"
Write-host "## Use Get-Help `$cmdlet or `$about to view"
Write-Host ""
