
# reset the lists of hosts prior to looping
$OutageHosts = $Null
# specify the time you want email notifications resent for hosts that are down
$EmailTimeOut = 30
# specify the time you want to cycle through your host lists.
$SleepTimeOut = 10
# specify the maximum hosts that can be down before the script is aborted
$MaxOutageCount = 2
# specify who gets notified
$NotificationTo = "garth@nuggetlab.com"
# specify where the notifications come from
$NotificationFrom = "admin@nuggetlab.com"
# SMTP server settings
$SMTPServer = "smtp.gmail.com"
$SMTPPort = 587
$SMTPCreds = (Import-Clixml c:\pass.dat)


# start looping here
Do{
$available = $Null
$notavailable = $Null
Write-Host (Get-Date)

# Read the File with the Hosts every cycle, this way to can add/remove hosts
# from the list without touching the script/scheduled task, 
# also hash/comment (#) out any hosts that are going for maintenance or are down.
Get-Content \\fsnugget\psv4\files\servers.txt | Where-Object {!($_ -match "#")} | 
ForEach-Object {
if(Test-Connection -ComputerName $_ -Count 1 -ErrorAction SilentlyContinue)
    {
     # if the Host is available then just write it to the screen
     write-host "Available host ---> "$_ -BackgroundColor Green -ForegroundColor White
     [Array]$available += $_
    }
else
    {
     # If the host is unavailable, give a warning to screen
     Write-Host "Unavailable host ------------> "$_ -BackgroundColor Magenta -ForegroundColor White
     if(!(Test-Connection -ComputerName $_ -Count 4 -ErrorAction silentlycontinue))
       {
        # If the host is still unavailable for 4 full pings, write error and send email
        Write-Host "Unavailable host ------------> "$_ -BackgroundColor Red -ForegroundColor White
        [Array]$notavailable += $_

        if ($OutageHosts -ne $Null)
            {
                if (!$OutageHosts.ContainsKey($_))
                {
                 # First time down add to the list and send email
                 Write-Host "$_ is not in the OutageHosts list, first time down"
                 $OutageHosts.Add($_,(Get-Date))

                 $body = "$_ has not responded for 5 pings at $(Get-Date)"

                 Send-MailMessage -Body $body -to $NotificationTo -from $NotificationFrom `
                  -Subject "Host $_ is down" -SmtpServer $SMTPServer -Credential $SMTPCreds -Port $SMTPPort -UseSsl
                }
                else
                {
                    # If the host is in the list do nothing for timeout and then remove from the list.
                    Write-Host "$_ is in the OutageHosts list"
                    if (((Get-Date) - $OutageHosts.Item($_)).TotalMinutes -gt $EmailTimeOut)
                    {$OutageHosts.Remove($_)}
                }
            }
        else
            {
                # First time down create the list and send email
                Write-Host "Adding $_ to OutageHosts."
                $OutageHosts = @{$_=(Get-Date)}
                $body = "$_ has not responded for 5 pings at $(Get-Date)" 
                Send-MailMessage -Body $body -to $Notificationto -from $NotificationFrom `
                 -Subject "Host $_ is down" -SmtpServer $SMTPServer -Credential $SMTPCreds -Port $SMTPPort -UseSsl
            } 
       }
    }
}
# Report to screen the details
Write-Host "Available count:"$available.count
Write-Host "Not available count:"$notavailable.count
Write-Host "Not available hosts:"
$OutageHosts
Write-Host ""
Write-Host "Sleeping $SleepTimeOut seconds"
Start-Sleep $SleepTimeOut

if ($OutageHosts.Count -ge $MaxOutageCount)
{
    # If there are more than a certain number of host down abort the script.
    $Exit = $True
    $body = $OutageHosts | Out-String
    Send-MailMessage -Body $body -to $notificationto -from $notificationfrom `
     -Subject "More than $MaxOutageCount hosts down, monitoring aborted" -SmtpServer $smtpServer -Credential $SMTPCreds -Port $SMTPPort -UseSsl
}
}
while ($Exit -ne $True)

