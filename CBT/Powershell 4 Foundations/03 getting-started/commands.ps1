Get-Service -DisplayName win*

Get-Command -CommandType cmdlet
Get-Command *service* -CommandType cmdlet
Get-Command *service* -CommandType cmdlet -Module ActiveDirectory
Get-Command -verb get -noun service
Get-Command -ParameterName computername