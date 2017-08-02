
#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: Remoting
#----------------------------------------------------


#I: Connect to another machine using an interactive 1:1 session, get services and exit the session

#region

Enter-PSSession APPNUGGET
Get-Service
Exit-PSSession

#endregion


#II: Run a command to view the most recent 10 system event logs across multiple servers using Invoke-Command

#region

Invoke-Command -ScriptBlock {Get-EventLog System -Newest 10} -ComputerName FSNUGGET,APPNUGGET

#endregion


#III: Create a new session to another machine, store a list of processes in a variable, disconnect from the session,
#     re-connect to the session from another powershell instance and view the variable. Exit and remove all sessions
#
#  1. Use New-PSSession to create a new session to another machine
#  2. Run Get-Process and store the results in a variable using that session
#  3. Use Disconnect-PSSession to disconnect the session
#  4. Use Connect-PSSession to connect to the disconnected session from another powershell instance
#  5. View the variable, exit the session and tear down all PSSessions

#region

#first powershell
$app = New-PSSession APPNUGGET
Invoke-Command -ScriptBlock {$p = Get-Process} -Session $app
Disconnect-PSSession $app

#second powershell
$app = Get-PSSession -ComputerName APPNUGGET | Connect-PSSession
Enter-PSSession -Session $app
$p
Exit-PSSession
Get-PSSession | Remove-PSSession


#endregion
