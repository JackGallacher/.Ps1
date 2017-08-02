#----------------------------------------------------------------
# Challenges for PowerShell 4 Foundations: Scripting - Essentials
#----------------------------------------------------------------

#Task 1 - Write a function that accepts a computername parameter and retrieves stopped services with
#   a startup type of automatic for the machines passed in, call the function.

#Task 2 - Write a script that utilizes the previous function and stores the results in a variable, loop through
#    the services variable and attempt to start them, utilize error handling to catch errors that may occur.

#Task 3 - Write a script that generates an HTML file (day-month-year_machine.html) containing information, 
#     services and event logs, accept parameters for computers, type of event log, and status of services.
#
#  1. Use WMI or CIM (or both!) to capture machine information
#  2. Use Get-Service to capture service information (pass a parameter to status value)
#  3. Use Get-EventLog to capture event logs (pass a parameter to log type value)
#  4. Use ConvertTo-HTML to generate an HTML file and Get-Date methods to name the file day-month-year_machine.html