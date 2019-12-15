$credObject = Get-Credential

$ExchOnlineSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credObject -Authentication Basic -AllowRedirection 

Import-PSSession $ExchOnlineSession

#Define Variable to rooms: 

$rooms = Get-Mailbox -RecipientTypeDetails RoomMailbox

# Display the meetings details $rooms | %{Set-CalendarProcessing $_ -AddOrganizerToSubject $true -DeleteComments $false -DeleteSubject $false}

$rooms | %{Set-MailboxFolderPermission $_":\Calendar" -User Default -AccessRights LimitedDetails} 

$confirmation = Read-Host -Prompt 'would you like to continue y/n ?'
if ($confirmation -eq 'y') {
    continue
} else {
        Remove-PSSession $Session   
}