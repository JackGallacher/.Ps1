
#-------------------------------------------------
# Challenges for PowerShell 4 Foundations: Objects
#-------------------------------------------------


#I: Examine the object members returned from Get-Process

#region

Get-Process | Get-Member

#endregion


#II: Write a pipeline to get processes where cpu utilization is greater than zero, return properties not shown in the default view, and sort the results by cpu descending.

#region

Get-Process | Where-Object CPU -gt 0 | Select-Object Name, CPU, Threads | Sort-Object CPU -Descending

#endregion


#III: Write a pipeline to find all .jpg and .png files created on a drive in the last 24 hours, copy them to another directory named backup.
#1. Get-ChildItem recursively with a filter for *.jpg, *.png against a drive.
#2. Where-Object against CreationTime property where it's greater than the current date (use AddHours(-24) on Get-Date).
#3. For-Each to iterate through the returned objects, using Copy-Item in the script block

#region

Get-ChildItem C:\ -Filter *.jpg, *.png -Recurse | Where-Object CreationTime -gt (Get-Date).AddHours(-24) | ForEach-Object {Copy-Item $_ -Destination '\\fsnugget\psv4\backup'}

#endregion