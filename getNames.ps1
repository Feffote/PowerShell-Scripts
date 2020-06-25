#pass file with list of domains and IDs; ex: COMPANY\500720321
$users = Get-Content 'C:\[...]\Users.txt' #pass route to the file .txt

$nameList = @()
foreach($user in $users){
    $dominio, $ID = $user.Split('\')
    $dominio += '.techint.net'
    $nameList += Get-ADUser $ID -Server $dominio -Properties mail | Select-Object samaccountname,name,mail 
}

$nameList | export-csv -Path .\nameList.csv -NoTypeInformation
