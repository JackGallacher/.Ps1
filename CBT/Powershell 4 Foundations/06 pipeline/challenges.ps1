#------------------------------------------------------
# Challenges for PowerShell 4 Foundations: The Pipeline
#------------------------------------------------------


# I: Write a pipeline that returns only running services and sort the results in descending order by displayname

#region " Solution for I "

Get-Services | Where-Object Status -eq Running | Sort-Object DisplayName

#endregion


# II: Write a pipeline that retrieves a list of files over 1GB on the system drive and save the results to an html file

#region " Solution for II "

Get-ChildItem $env:SystemDrive | Where-Object Length -gt 1GB | ConvertTo-HTML | Out-File \\fsnugget\psv4\files\bigones.html

#endregion


# III: Write a pipeline that retrieves the name, synopsis, and modulename properties from get-help for all "Get-" cmdlets in the Microsoft* modules, output the results to a grid for interactive analysis.
# 1. Use Get-Command to retrieve Get- cmdlets in the Microsoft* modules
# 2. Pipe the results to Get-Help
# 3. Select name, synopsis, modulename properties from the help objects
# 4. Output the results to a GridView

#region " Solution for III "

Get-Command -Verb get -Module microsoft* | Get-Help | Select-Object name, synopsis, modulename | Out-GridView

#endregion