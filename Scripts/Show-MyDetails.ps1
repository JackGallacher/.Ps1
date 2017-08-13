Function Show-MyDetails{
<#
.SYNOPSIS
A function that takes input of a first name, second name and age and prints it back to the console.

.DESCRIPTION
A function that takes manditory input (using validation) of a first name, second name and age and prints it back to the console.

.EXAMPLE
Show-MyDetails -firstName Jack -secondName Gallacher -age 24
#>
    param(   
        [Parameter(Mandatory=$true)]
        [String]$FirstName,

        [Parameter(Mandatory=$true)]
        [String]$SecondName,

        [Parameter(Mandatory=$true)]
        [Int]$Age
    )
    Write-Output "FirstName: $FirstName, SecondName: $SecondName, Age: $Age"
}
