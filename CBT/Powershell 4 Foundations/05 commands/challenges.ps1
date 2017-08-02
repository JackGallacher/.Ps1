#--------------------------------------------------
# Challenges for PowerShell 4 Foundations: Commands
#--------------------------------------------------


# I: Display all services running on the localhost that have a displayname beginning with the letter B

#region " Solution for I "

Get-Service -DisplayName b*

#endregion


# II: Display a list of commands that are cmdlets in any module that starts with Microsoft

#region " Solution for II "

Get-Command -CommandType Cmdlet -Module Microsoft*

#endregion


# III: Copy the contents of a directory, including subdirectories from one location to another
# 1. Find all cmdlets that start with the verb 'copy'
# 2. Review the help topic for Copy-Item
# 3. Use Copy-Item with positional parameters
# 4. Switch directories (cd) to the destination directory and list the contents (dir)
# 5. Discover the cmdlets underneath the aliases cd and dir used above

#region " Solution for III "

Get-Command -Verb copy
Get-Help Copy-Item
Copy-Item '\\fsnugget\psv4' 'c:\' -recurse
cd 'c:\psv4'
dir
Get-Alias cd, dir
#endregion