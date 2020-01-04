 Connect-AzureAD
 
 $domain = "newdomain.com"
Get-AzureADUser -All $True | Where { $_.UserPrincipalName.ToLower().EndsWith("OldDomain.com") } |
ForEach {
 $newupn = $_.UserPrincipalName.Split("@")[0] + "@" + $domain
 Write-Host "Changing UPN value from: "$_.UserPrincipalName" to: " $newupn -ForegroundColor Yellow
 Set-AzureADUser -ObjectId $_.UserPrincipalName  -UserPrincipalName $newupn
}