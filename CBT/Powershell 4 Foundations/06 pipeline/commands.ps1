
# piping data (objects)
Get-Service | Sort-Object Name
Get-Service | Sort-Object Name | Out-Gridview
Get-Service | Sort-Object Name | Select-Object * | Out-Gridview

Get-Service bit* -ComputerName (Get-Content \\fsnugget\psv4\files\servers.txt) |
    Sort-Object Name |
    Select-Object Name, Status, MachineName | 
    Format-List


# exporting
Get-Service win* | Where-Object Status -eq Running | Export-Csv services.csv
notepad services.csv

Get-Service win* | Where-Object Status -eq Running | ConvertTo-Html | Out-File services.html
start services.html