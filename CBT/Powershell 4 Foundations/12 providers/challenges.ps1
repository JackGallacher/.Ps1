
#----------------------------------------------------
# Challenges for PowerShell 4 Foundations: Providers
#----------------------------------------------------


#I: Display a list of PowerShell providers, switch to the environment drive,
#   create a new environment variable, and list all environment variables.

#region

Get-PSProvider
cd env:
New-Item -Name myvar -Value hi!
dir

#endregion


#II: Use PowerShell to navigate to the HKCU:\software\microsoft\windows\currentversion hive 
#    and perform a wildcard search for anything within that contains the word "internet" .  

#region

cd HKCU:\software\microsoft\windows\currentversion\
dir *internet*

#endregion


#III: Use PowerShell create a new file on a network share, add some test data,
#     set it to read-only, and read the data back into the shell.
# 1. Navigation cmdlets (set-location)
# 2. Item cmdlets (new-item)
# 3. Property cmdlets (new-itemproperty)
# 4. Content cmdlets (get-content, set-content)
    
#region
ls
cd c:

New-Item myfile.txt -ItemType File
Set-Content myfile.txt -Value "hi!"
Set-ItemProperty myfile.txt -Name IsReadOnly -Value $true
Get-Content myfile.txt


#endregion
