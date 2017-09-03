Function ConvertTo-Clixml{
<#
.SYNOPSIS
Takes in a string value and copies the content of a Export-Clixml to the clipboard for pasting into a database.

.DESCRIPTION
Takes in a manditory string value and exports it as clixml to a temporary file, it the imports the temporary file back in as clixml as copies the content to the clipboard. It then deletes the temporary file.

.EXAMPLE
ConvertTo-Clixml [Value to convert]
#>
    param(    
        [Parameter(Mandatory=$True, ValueFromPipeline = $True)]
        [ValidateScript({$_.GetType -isnot [System.Array]})] 
        [ValidateScript({$_.GetType -isnot [System.Collections.Hashtable]})]
        [System.Object]$Value
    )

    Try{
        $TemporaryLocation = [System.IO.Path]::GetTempFileName()
        $Value | Export-Clixml -Path $TemporaryLocation
        Get-Content -Path $TemporaryLocation | clip
        Remove-Item $TemporaryLocation
    }
    Catch{
        Write-Error "Error exporting to Clixml. Message:'$($_.Exception.Message)'." -ErrorAction Continue
        Throw  
    }
}