
#--------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: Formatting Output
#--------------------------------------------------------------


#I: Return a list of all processes, use format-wide to output the name property using 6 columns

#region

Get-Process | Format-Wide -Property Name -Column 6

#endregion


#II: Return a table of the 25 most recent system event logs entries sorted by EntryType. Output
#    Source, TimeGenerated, and message using format-table, then group by EntryType, wrap the results

#region

Get-Eventlog system | Select-Object -first 25 | Sort-Object EntryType | 
    Format-Table Source, TimeGenerated, Message -GroupBy EntryType -Wrap

#endregion


#III: Return a table of processes, use format-table to return ID, Name, VM and define a custom property 
#     named VM(MB) with an expression that converts the VM value to MB and use right alignment with 
#     a numeric string format for 2 decimals, autosize the results
#     
#1. 
#2. 
#3. 

#region

Get-Process | Format-Table -Property ID, Name, VM, @{n='VM(MB)';e={$_.VM / 1mb};align='right';formatstring='N2'} -AutoSize

#endregion