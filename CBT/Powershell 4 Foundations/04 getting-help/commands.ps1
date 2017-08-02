
# updating help from the internet
Get-Help Update-Help -Examples
Update-Help

# saving & updating help locally
Save-Help -DestinationPath \\fsnugget\psv4\help
Update-Help -SourcePath \\fsnugget\psv4\help

# searching help
Get-Help *variable*
Get-Help about_automatic_variables -ShowWindow

# getting help
help Get-Service -Detailed #params & examples
help Get-Service -Examples #examples
help Get-Service -Full #full help: params, examples, notes, input/output types
help Get-Service -Parameter d*

# using help
help Get-Service -ShowWindow
Get-Service bi* -ComputerName DCNUGGET, FSNUGGET | Select-Object MachineName,Status, DisplayName | Format-List

help Start-Service -Online
Get-Service bi* -ComputerName DCNUGGET, FSNUGGET | Start-Service #input object parameter set
Start-Service -DisplayName 'Background Intelligent Transfer Service' -c DCNUGGET, FSNUGGET #displayname parameter set
Start-Service bi* -ComputerName DCNUGGET, FSNUGGET #default parameter set