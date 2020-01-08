###################################################################
# Created By : Maor Paz
# Date of creation : 03/10/2019
# Purpose of script: Transfer all Domain to another primary Domain
# Version: 1.0.0
# Contact info: Maorp@restartit.co.il
###################################################################

# Enable execution policy:
Set-ExecutionPolicy -Scope Currentgroup -ExecutionPolicy Bypass -Force;
Set-ExecutionPolicy -Scope Currentgroup -ExecutionPolicy Unrestricted -Force;

# Connect to 365
$credentials = Get-Credential
Write-Output "Getting the Exchange Online cmdlets"

# import PSsession of 365
$Session = New-PSSession -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
-ConfigurationName Microsoft.Exchange -Credential $credentials `
-Authentication Basic -AllowRedirection
Import-PSSession $Session

# Get info of mailboxex
$groups = Get-UnifiedGroup | Where-Object{$_.PrimarySMTPAddress -match "DomainName1.com"}

# Adding Alias to each MailBox
foreach($group in $groups){
    Write-Host "Adding Alias $($group.alias)@DomainName2.com"
    Set-UnifiedGroup –IdentityGroup $group.PrimarySmtpAddress -EmailAddresses @{add="$($group.Alias)@DomainName3.com"}
    Set-Mailbox -Identity $group.name -EmailAddresses SMTP:$($group.Alias)@DomainName3.com
}

$confirmation = Read-Host -Prompt 'would you like to continue y/n ?'
if ($confirmation -eq 'y') {
    continue
} else {
        Remove-PSSession $Session   
}