
#--------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: Extending Objects
#--------------------------------------------------------------


#I: View only the extended members of a System.IO.FileInfo object

#region

Get-ChildItem c:\ -File | Get-Member -View Extended

#endregion


#II: Extend the System.IO.FileInfo type to add a custom ScriptProperty for LengthMB

#region

Update-TypeData -TypeName System.IO.FileInfo -MemberType ScriptProperty -MemberName LengthMB -Value {[math]::Round($this.length/1MB,2)} 
Get-ChildItem c:\ -File | Select-Object *
Get-ChildItem c:\ -File | Get-Member -View Extended

#endregion


#III: Extend the objects returned from Get-ChildItem using Add-Member to include a LastWrittenTo ScriptProperty
#     that contains the difference between the current date and LastWriteTime in the format...
#     Days.Hours:Minutes:Seconds (eg: 04.08:12:35)
#     
#1. Create a variable to store Directory and File objects.
#2. Use Add-Member against the variable to add a ScriptProperty for LastWrittenTo
#3. Pipe the variable to Select-Object to view the new script property

#region

$d = Get-ChildItem c:\mydir

$d | Add-Member -MemberType ScriptProperty `
                -Name LastWrittenTo `
                -Value {((Get-Date) - $this.LastWriteTime).ToString("dd\.hh\:mm\:ss")} `
                -Force

$d | Select-Object FullName, LastWriteTime, LastWrittenTo

#endregion