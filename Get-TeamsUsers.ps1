#get list of users in a Microsoft Teams group

#connect module and enter credentials
Connect-MicrosoftTeams
#get ID of the groups to which a user belongs
Get-Team -User #--- your email here
#pass desired group ID
Get-TeamUser -GroupId [...Group ID here...] | Select-Object User | Export-Csv -Path .\Desktop\TeamsUsers.csv -NoTypeInformation