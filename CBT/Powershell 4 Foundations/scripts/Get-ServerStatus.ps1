<#
.SYNOPSIS
Emails a machine status report
.DESCRIPTION
Generates an HTML email with machine status (online/offline) and uptime
.PARAMETER ComputerName
The name of the Computer(s) you want to run the command against.
.EXAMPLE
Get-ServerDown -ComputerName DCNUGGET
.EXAMPLE
Get-ServerDown -ComputerName DCNUGGET,APPNUGGET
#>

param
(
    [array]$ComputerName,
    [switch]$OfflineOnly = $false
)

function Get-ComputerUptime {
	param ($ComputerName)

	$pc = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName
	$booted = $pc.ConvertToDateTime($pc.LastBootUpTime)
	$uptime = (Get-Date) - $booted

	Return [String]::Format('{0:00} Days, {1:00} Hours, {2:00} Minutes, {3:00} Seconds', $uptime.Days, $uptime.Hours, $uptime.Minutes, $uptime.Seconds)
}

function Send-GmailMessage {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Recipient,
        [String]$From = "admin@nuggetlab.com",
        [String]$Subject,
        [String]$Body
    )
            
    #splatting parameters
    $param = @{
        SmtpServer = 'smtp.gmail.com'
        Port = 587
        UseSsl = $true
        Credential = (Import-Clixml c:\pass.dat)
        From = $From
        To = $Recipient
        Subject = $Subject
        Body = $Body
    }

    Send-MailMessage @param

}

# loop through all computers in parameter
$results = ForEach ($computer in $ComputerName)
{   
    [PSCustomObject]@{
        Computer = $computer
        Online = Test-Connection $computer -Quiet -Count 1
        Uptime = Get-ComputerUpTime $computer
    }
}

$header = @"
<style type='text/css'>
table {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
th {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
td {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
"@

# generate html
if ($OfflineOnly) 
{
    $HTML = $results | Where-Object Online -eq $false | ConvertTo-Html -Head $header -PreContent "<h3>Server Status Report</h3>" -PostContent "<p><br/><h5>Generated: $(Get-Date)</</p>" | Out-String
}
else
{
    $HTML = $results | ConvertTo-Html -Head $header -PreContent "<h3>Server Status Report</h3>" -PostContent "<p><br/><h6>Generated: $(Get-Date)</p>" | Out-String
}


# email html report
if ($results.count -gt 0)
{
    Send-GmailMessage -Recipient garth@nuggetlab.com `
                      -Subject "Server Status Report" `
                      -Body $HTML   
}