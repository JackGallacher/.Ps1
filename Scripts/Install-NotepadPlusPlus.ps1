WorkFlow Install-NotepadPlusPlus{
<#
.SYNOPSIS
Installs the software 'Notepad++' from a target executable to a target location.

.DESCRIPTION
Installs the software 'Notepad++' from a target executable to a target location. This script takes a .exe install file and verifies it, silently installing it. It then verifies that the application executable exists. If the install location does not exist, it will be created at runtime.

.EXAMPLE
Install-NotepadPlusPlus -InstallFile [Installation .exe] -InstallLocation [Installation folder]
#>

    param(
        [ValidateScript({Test-Path -Path $_ -Include *exe})]
        [Parameter(Mandatory=$True)]       
        [String]$InstallFile,
       
        #[ValidateScript({if($InstallLocation -ne $NULL){Test-Path -Path $_}})]
        [String]$InstallLocation
        ) 

        sequence{
            Write-Verbose 'Attempting to install Notepad++'
            Try{

                if($InstallLocation -ne $NULL){                   
                    Start-Process -FilePath $InstallFile -ArgumentList "/S /D=$InstallLocation" -Wait
                    Test-Path -Path $InstallLocation
                }
                else{
                    Write-Verbose "No Install Path" -Verbose
                    Start-Process -FilePath $InstallFile -ArgumentList "/S" -Wait
                }              
            }
            Catch {       
                Write-Error "Error trying to install Notepad++, message:'$($_.Exception.Message)'." -ErrorAction Continue
                Throw   
            }  
            Test-Path -Path ($InstallLocation + "\*notepad++*.exe")

            
            
                   
            if($? -eq $true){
                Write-Verbose "Notepad++ Succesfully Installed"
            }else{
                Write-Verbose "Notepad++ not Installed, please verify the installation media and path are correct."
            }
        }
}    

    