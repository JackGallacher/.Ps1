
param(
    [string]$CsvPath
)

Write-Host "Creating Groups.."

$lightsidegroup = Get-ADGroup -Filter * | Where-Object Name -eq 'Lightside Admins'
if ($lightsidegroup -eq $Null) {
    New-ADGroup -Name "Lightside Admins" `
                -SamAccountName LightsideAdmins `
                -GroupCategory Security `
                -GroupScope Global `
                -DisplayName "Lightside Administrators" `
                -Path "OU=Lightside,DC=nuggetlab,DC=local" `
                -Description "Rebel scum"
    
    Write-Host "Lighside group created!"
}

$darksidegroup = Get-ADGroup -Filter * | Where-Object Name -eq 'Darkside Admins'
if ($darksidegroup -eq $Null) {
    New-ADGroup -Name "Darkside Admins" `
                -SamAccountName DarksideAdmins `
                -GroupCategory Security `
                -GroupScope Global `
                -DisplayName "Darkside Administrators" `
                -Path "OU=Darkside,DC=nuggetlab,DC=local" `
                -Description "Imperial jerks"

    Write-Host "Darkside group created!"
}

Write-Host "Creating AD Users.."

Import-Csv $CsvPath | ForEach-Object {

    $user = @{
        GivenName = $_.GivenName
        SurName = $_.Surname
        Initials = $_.Initials
        Name = $_.Name
        SamAccountName = $_.SamAccountName
        Description = $_.Description
        Department = $_.Department
        EmployeeID = $_.ForceID
        Path = "OU=$($_.Side)side,DC=nuggetlab,DC=local"
        Enabled = [boolean]$_.Enabled
        AccountPassword = ConvertTo-SecureString -AsPlainText $_.Password -Force
    }

    try {
        New-ADUser @user -ChangePasswordAtLogon $true -ErrorAction Stop

        if ($_.Role -eq "Admin") { 
            Add-ADGroupMember -Identity "$($_.Side)sideAdmins" -Members $_.SamAccountName 
        }
    }
    catch {
        Write-Host "Something went wrong."
        Write-Host $_
    }
}

Write-Host "Import complete!"