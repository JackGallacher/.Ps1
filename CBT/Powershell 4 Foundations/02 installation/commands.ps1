
# NET 4.5: http://www.microsoft.com/en-us/download/details.aspx?id=42642
# WMF 4.0: http://www.microsoft.com/en-us/download/details.aspx?id=40855


#region " PowerShell Version Check "

$PSVersionTable

Invoke-Command -ComputerName DCNUGGET, APPNUGGET, FSNUGGET, CL8NUGGET, CL7NUGGET -ScriptBlock {$PSVersionTable.PSVersion}

Invoke-Command -ComputerName (Get-ADComputer -Filter * | Select-Object -expand Name) -ScriptBlock {$PSVersionTable.PSVersion}

#endregion


#region " OS Version & Service Pack Check "

Get-WmiObject -Class Win32_OperatingSystem | Format-Table Caption, ServicePackMajorVersion -AutoSize

#endregion


#region " .NET 4.5 Check "

(Get-ItemProperty -Path ‘HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full’ -ErrorAction SilentlyContinue).Version -like ‘4.5*’

#endregion