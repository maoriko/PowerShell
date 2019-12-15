# Connect to 365
$credentials = Get-Credential
Write-Output "Getting the Exchange Online cmdlets"

# import PSsession of 365
$Session = New-PSSession -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
-ConfigurationName Microsoft.Exchange -Credential $credentials `
-Authentication Basic -AllowRedirection
Import-PSSession $Session


# Remove-PSSession $Session


# Get info about thep group + Check if exist 

Get-UnifiedGroup -Identity GroupName@domain1.com

Set-UnifiedGroup -Identity GroupName@domain1.com -EmailAddresses @{Add='GroupName@domain2.com'}

Set-UnifiedGroup -Identity "GroupName" -PrimarySmtpAddress "GroupName@domain2.com"

Get-UnifiedGroup -Identity GroupName@domain2.com | FL EmailAddresses




# Exit Session if finished?
$confirmation = Read-Host -Prompt 'would you like to continue y/n ?'
if ($confirmation -eq 'y') {
    continue
} else {
        Remove-PSSession $Session   
}
