
#formatting rules
Get-Process w*
Get-Process w* | gm

cd $pshome
start .\dotnettypes.format.ps1xml

Get-ChildItem -File
start .\types.format.ps1xml


#format-wide
Get-Service | select-object name
Get-Service | Format-Wide -Property Name
Get-Service | Format-Wide -Property Name -Column 4

#format-list
Get-Service | Format-List -Property Name, DisplayName, Status
Get-Service | Format-List -Property Name, DisplayName, Status -GroupBy Status
Get-Service | Sort-Object Status | Format-List -Property Name, DisplayName, Status -GroupBy Status
gsv | fl *
gsv | select -first 5 | fl 

#format-table
Get-Service | Format-Table -Property Name, DisplayName, Status
Get-Service | Format-Table -Property Name, DisplayName, Status -AutoSize
gsv | ft *
gsv | ft * -wrap
gsv | ft * -wrap -autosize

get-eventlog system | select -first 10 | format-table -property EntryType, Source, TimeGenerated, `
    @{n='When';e={((Get-Date) - $_.TimeGenerated)};align='right';formatstring='dd\.hh\:mm\:ss'} -AutoSize


#controlling default output
Update-TypeData -TypeName System.DateTime -DefaultDisplayPropertySet DateTime, DayOfYear, Quarter
Get-Date | Format-List

Update-TypeData -TypeName System.DateTime `
                -MemberType ScriptProperty `
                -MemberName Quarter `
                -Value {if ($this.Month -in @(1,2,3)) {"Q1"}  `
                        elseif ($this.Month -in @(4,5,6)) {"Q2"} `
                        elseif ($this.Month -in @(7,8,9)) {"Q3"} `
                        else {"Q4"}}
