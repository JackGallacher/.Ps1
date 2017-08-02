
#--------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: The Pipeline Returns
#--------------------------------------------------------------


#I: Review the full help topic for Get-EventLog, does this cmdlet accept pipeline input?
#   Review the full help topic for Get-Hotfix, which parameters accept pipeline input?

#region

    Get-Help Get-Eventlog -Full
#   1. No, nothing in this cmdlet accepts pipeline input.

    Get-Help Get-HotFix -Full
#   2. The ComputerName paramater accepts pipeline input ByPropertyName

#endregion


#II: Retrieve the most recent system event log entry from multiple machines using parenthetical binding.
#    Could you have accomplished this using parameter binding? Why Not?

#region

   Get-EventLog system -ComputerName (Get-Content .\computers.txt) | Select-Object -first 1
   #No you can not use parameter binding as the computername parameter does not accept pipeline input

#endregion


#III: Use parameter binding to pass a list of computers from Get-ADComputer to the Get-Hotfix cmdlet 
#     to view installed hotfixes across servers in the network.
    
#region

   Get-ADComputer -filter * | Select-Object @{n='computername';e={$_.name}} | Get-Hotfix

#endregion
