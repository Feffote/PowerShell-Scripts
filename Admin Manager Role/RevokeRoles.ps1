#import module from local
Import-Module 'C:\Users\[...]\ReportingServicesTools-master\ReportingServicesTools\ReportingServicesTools.psm1'

#specify the content server
$reporServerUri = 'http://[...]/reports/'
$session = New-RsRestSession -ReportPortalUri $reporServerUri

#specify the folder you want to modify
$rsFolderPath = '[...]' #ex: '/Business Analytics Reports/Script Testing' 

#create a list of all folders/reports within the folder specified above
$folderList = Get-RsChildItem -ReportServerUri $reporServerUri -RsFolder $rsFolderPath -Recurse | Select-Object Path
#users that should not be modified
$VIP = @('[...]','[...]','[...]') #ex: 'COMPANY/55322341', 'COMPANY/00321222' 
#roles to grant
$roles = @('Browser', 'Publisher', 'Report Builder') #inclue all the roles you want to grant

#move folder by folder in $folderList
foreach($folder in $folderList.Path){
    #create a list of all the user with Content Manager access role
    $userList = Get-RsCatalogItemRole -ReportServerUri $reporServerUri -Path $folder | Select-Object Identity,Roles | ? {$_.Roles.Name -Contains "Content Manager"}
    Write-Output "`nFolder: ", $folder, "Users: "
    #move user by user in the list created above
    foreach($user in $userList.Identity){
        #if the user is not in $VIP list then continues
        if(!($user -in $VIP)){
            $user
            #revoke all roles to the user
            Revoke-AccessOnCatalogItem -ReportServerUri $reporServerUri -Path $folder -Identity $user
            foreach($role in $roles){
                #grant to the user the roles specified above
                Grant-RsCatalogItemRole -ReportServerUri $reporServerUri -Path $folder -RoleName $role  -Identity $user
            }
        }
    }
}
"`nFinish!"