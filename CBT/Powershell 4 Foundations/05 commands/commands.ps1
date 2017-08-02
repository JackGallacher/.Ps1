
# commands
Get-Help Get-Command -Parameter CommandType

Get-Command *proc* -CommandType Cmdlet
Get-Command p* -CommandType Application
Get-Command cl* -CommandType Function

Get-Verb

Get-Command *service*
Get-Help New-Service -ShowWindow
Show-Command New-Service

New-Service -BinaryPathName c:\system32\notepad.exe `
            -Name np -Description "Notepad as a service for fun" `
            -DisplayName Notepad `
            -StartupType Disabled

(Get-WmiObject -Class Win32_Service -Filter "Name='np'").delete()

# aliases
Get-Command -CommandType alias

Get-Alias dir
Get-Alias ls
Get-Alias -Definition Get-Childitem

Help *alias*
Get-Help New-Alias
New-Alias np c:\system32\notepad.exe #wrong path
Set-Alias -Name np -Value notepad.exe

np

Export-Alias my-aliases.csv
Import-Alias my-aliases.csv

np