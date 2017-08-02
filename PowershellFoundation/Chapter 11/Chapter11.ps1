#--------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: The Pipeline Returns
#--------------------------------------------------------------

#Task 1 - Review the full help topic for Get-EventLog, does this cmdlet accept pipeline input?
#Review the full help topic for Get-Hotfix, which parameters accept pipeline input?
Get-Help Get-EventLog -Full #Does not accept pipeline input
Get-Help Get-HotFix -Full #-ComputerName accepts propertt name pipeline input

#Tak 2 - Retrieve the most recent system event log entry from multiple machines using parenthetical binding.
#Could you have accomplished this using parameter binding? Why Not?
Get-EventLog system -ComputerName (Get-Content .\computers.txt) | Select-Object -first 1

#Task 3 -  Use parameter binding to pass a list of computers from Get-ADComputer to the Get-Hotfix cmdlet 
#to view installed hotfixes across servers in the network.
Get-ADComputer -filter * | Select-Object @{n='computername';e={$_.name}} | Get-Hotfix