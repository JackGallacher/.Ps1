#---------------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: Scripting - Getting Started
#---------------------------------------------------------------------

#Task 1 - Set the execution policy to Restricted, verify the setting, and execute the test-remote.ps1 
Set-ExecutionPolicy -ExecutionPolicy Restricted
Get-ExecutionPolicy

#Task 2 - Set the execution policy to RemoteSigned and execute the test-remote.ps1 script, attempt to execute the 
#    canPing function from outside of the script. execute test-remote.ps1 using dot-sourcing and execute
#    the canPing function from outside of the script. What did dot-sourcing the script do?
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
.\test-remote.ps1
canPing

. .\test-remote.ps1
canPing

#Task 3 - Set the execution policy to AllSigned and execute the test-remote.ps1 script, generate a self-signed 
#     certificate and sign the test-remote.ps1 script, view the script definition to verify the signature
#     and execute test-remote.ps1.
Set-ExecutionPolicy -ExecutionPolicy AllSigned
.\test-remote.ps1

makecert -n "CN=PowerShell Local Certificate Root" -a sha1 -eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer -ss Root -sr localMachine
makecert -pe -n "CN=PowerShell User" -ss MY -a sha1 -eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer

$cert = @(Get-ChildItem cert:\CurrentUser\My -CodeSigningCert)[0]
Set-AuthenticodeSignature .\test-remote.ps1 $cert

.\test-remote.ps1