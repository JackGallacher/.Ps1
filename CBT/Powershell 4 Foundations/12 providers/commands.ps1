
# providers
Get-PSProvider
Get-PSDrive

dir c:\

cd env:
dir

cd hklm:
dir

# filesystem
New-PSDrive -Name Nuggetlab -PSProvider FileSystem -Root "\\fsnugget\psv4\"
Get-PSDrive
Set-Location Nuggetlab:
Get-ChildItem
Remove-PSDrive Nuggetlab

Get-Command -Noun Item
Get-Command -Noun ItemProperty

New-Item MyFile.txt -ItemType File
Set-Content -Path MyFile.txt -value "Hello!"
Set-ItemProperty -Path MyFile.txt -name IsReadOnly -value $true
dir


# registry
cd HKLM:
cd .\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell
Get-ChildItem
Get-ItemProperty -Path . -Name executionpolicy

cd HKCU:\SOFTWARE
New-Item Nuggets -ItemType directory
New-ItemProperty -Path .\Nuggets -Name TheKeyofWin -PropertyType String -Value "MyRegData"
Set-ItemProperty -Path .\Nuggets -Name TheKeyofWin -Value "NewRegData"

Remove-Item -Path .\Nuggets
Get-ChildItem .\Nuggets


# cert store
cd cert:
ls
cd CurrentUser
ls
cd Root
ls
Get-ChildItem 039EEDB80BE7A03C6953893B20D2D9323A4C2AFD | fl *


# variables
dir variables:
myvar = "dsfsdf"
dir variables:


#path vs literalpath
New-Item File.txt, File[1].txt, File[2].txt -Type File
dir
Get-ChildItem -Path File[1].txt
Get-ChildItem -LiteralPath File[1].txt

Remove-Item -Path File*.txt

