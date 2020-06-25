#pasar archivo con lista de dominios y IDs; ej EMPRESA\500720321
$users = Get-Content 'C:\[...]\Users.txt' #pasar ruta hacia el archivo .txt

$nameList = @()
foreach($user in $users){
    $dominio, $ID = $user.Split('\')
    $dominio += '.techint.net'
    $nameList += Get-ADUser $ID -Server $dominio -Properties mail | Select-Object samaccountname,name,mail 
}

$nameList | export-csv -Path .\nameList.csv -NoTypeInformation