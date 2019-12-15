 Connect-AzureAD
 
 $domain = "ourbond.com"
Get-AzureADUser -All $True | Where { $_.UserPrincipalName.ToLower().EndsWith("tg-17.com") } |
ForEach {
 $newupn = $_.UserPrincipalName.Split("@")[0] + "@" + $domain
 Write-Host "Changing UPN value from: "$_.UserPrincipalName" to: " $newupn -ForegroundColor Yellow
 Set-AzureADUser -ObjectId $_.UserPrincipalName  -UserPrincipalName $newupn
}