
$Domain = '@nuggetlab.local'
$Users = Import-Csv '\\fsnugget\files\users.csv'

foreach ($User in $Users)
{
    $FullName = $User.FirstName + ' ' + $User.LastName
    $UPN = $User.ID + $Domain
    $UNC = '\\fsnugget\profiles\'

    New-ADUser -Name $FullName -GivenName $User.FirstName -Surname $User.LastName 
               -SamAccountName $User.ID -DisplayName $FullName -UserPrincipalName $UPN 
               -AccountPasssword (ConvertTo-SecureString -AsPlainText 'Pa$$w0rd' -Force)
               -Path 'OU=Domain Users,DC=nuggetlab,DC=local'
    
    Set-ADUser -Identity $User.ID -PasswordNeverExpires $true

    Enable-ADAccount -Identity $User.ID
}