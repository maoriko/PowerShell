###################################################################
# Created By : Maor Paz
# Date of creation : 03/10/2019
# Purpose of script: Transfer all Domain to another primary Domain
# Version: 1.1.1
# Contact info: Maor.paz@pc4us.co.il
###################################################################

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

# Get info of mailboxex
$mailboxes = Get-Mailbox | Where-Object{$_.PrimarySMTPAddress -match "domain1.com"}

# Adding Alias to each MailBox
foreach($user in $mailboxes){
    Write-Host "Adding Alias $($user.alias)@domain1.com"
    Set-Mailbox $user.PrimarySmtpAddress -EmailAddresses @{add="$($user.Alias)@domain2.com"}
    Set-Mailbox -Identity $user.name -EmailAddresses SMTP:$($user.Alias)@domain2.com
}

$confirmation = Read-Host -Prompt 'would you like to continue y/n ?'
if ($confirmation -eq 'y') {
    continue
} else {
        Remove-PSSession $Session   
}


