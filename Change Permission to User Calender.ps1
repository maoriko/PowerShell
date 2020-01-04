# Enable execution policy:
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force;

# Connect to 365
$credentials = Get-Credential
Write-Output "Getting the Exchange Online cmdlets"

# import PSsession of 365
$Session = New-PSSession -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
-ConfigurationName Microsoft.Exchange -Credential $credentials `
-Authentication Basic -AllowRedirection
Import-PSSession $Session

Add-MailboxFolderPermission -Identity username@domain.com:\calendar -user username2@domain.com.com -AccessRights Editor

$confirmation = Read-Host -Prompt 'would you like to continue y/n ?'
if ($confirmation -eq 'y') {
    continue
} else {
        Remove-PSSession $Session   
}
