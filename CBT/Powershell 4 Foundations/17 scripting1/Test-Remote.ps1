<#
.SYNOPSIS
Tests a machines connectivity and remoting
.DESCRIPTION
Tests a machines connectivity using ping and remoting capabilities using PSSession
.PARAMETER ComputerName
Name of the computer you want to run the command against
.EXAMPLE
Test-Remote -ComputerName DCNUGGET
.EXAMPLE
Test-Remote
#>


# parameters
param ($ComputerName = "localhost")

# test connectivity via ping, returns true/false
function CanPing {
   $response = Test-Connection $ComputerName -Quiet -ErrorAction SilentlyContinue

   if (!$response)
       {write-host "Ping failed: $ComputerName."; return $false}
   else
       {write-host "Ping succeeded: $ComputerName"; return $true}
}

# test remoting via sessions
function CanRemote {
    $session = New-PSSession $ComputerName -ErrorAction SilentlyContinue

    if ($session -is [System.Management.Automation.Runspaces.PSSession])
        {Write-Host "Remote test succeeded: $ComputerName."}
    else
        {Write-Host "Remote test failed: $ComputerName."}
}

if (CanPing $ComputerName) {CanRemote $ComputerName}