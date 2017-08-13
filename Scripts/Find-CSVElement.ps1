Function Find-CSVElement{   
<#
.SYNOPSIS
A function that loops through any .csv file to find a specified keyword.

.DESCRIPTION
A function that loops through a .csv to find a specified keyword and print a notifiction message when an instance has been found. 
This function will also validate that the filepath of the .csv exists and that its import has been completed correctly.

.EXAMPLE
Find-CSVElement -FilePath C:\Desktop\myFile.csv -Keyword 'Bob'
#>
    param(
        [Parameter(Mandatory=$true)]
        [String]$FilePath,

        [Parameter(Mandatory=$true)]
        [String]$Keyword
    )

    if(Test-Path $FilePath){
        try{
            $CSV = (Import-Csv -Path $FilePath)
        }
        catch
        {
            Write-Output 'Failed to import .csv file.'
        }
    }

    [Array]$CSVHeaders = (Get-Content $FilePath | Select-Object -First 1).Split(",")
    for($i = 0; $i -lt ($CSVHeaders.Length); $i++){
    foreach($Element in $CSV){
            if($Element.($CSVHeaders[$i].ToString()) -eq $keyword){
                Write-Output "Found Keyword $Keyword in column "$CSVHeaders[$i].ToString()""
            }
        }
    }   
}