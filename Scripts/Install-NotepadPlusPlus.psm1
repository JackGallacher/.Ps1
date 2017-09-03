Function Install-NotepadPlusPlus{
<#
.SYNOPSIS
Installs the software 'Notepad++' from a target executable to a target location.

.DESCRIPTION
Installs the software 'Notepad++' from a target executable to a target location. This script takes a .exe install file, verifies it and silently installs it. If the install location does not exist, it will be created at runtime.

.EXAMPLE
Install-NotepadPlusPlus -InstallFile [Installation .exe] -InstallLocation [Installation folder]
#>

    param(
        [ValidateScript({Test-Path -Path $_ -Include *exe})]
        [Parameter(Mandatory=$True)]       
        [String]$InstallFile,
         
        [ValidateScript({Test-Path -Path $_ -IsValid })]      
        [String]$InstallLocation
        ) 

        [String]$Arguments = "/S"
        if($InstallLocation -ne $NULL){
            $Arguments = "/S /D=$InstallLocation"
        }

        Write-Verbose 'Attempting to install Notepad++'
        Try{
            
            [System.Diagnostics.Process]$Install = Start-Process -FilePath $InstallFile -ArgumentList $Arguments -Wait -PassThru                                       
        }
        Catch {       
            Write-Error "Error trying to install Notepad++, Exit code: '$($Install.ExitCode)'. Message:'$($_.Exception.Message)'." -ErrorAction Continue
            Throw         
        }

        if($Install.ExitCode -eq 0){
            Write-Verbose "Notepad++ succesfully installed" 
        }else{
            Write-Error "Error trying to install Notepad++, Exit code: '$($Install.ExitCode)'." -ErrorAction Continue
            Throw "Notepad++ could not be installed"
        }       
}    

    