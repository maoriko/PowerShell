$ErrorActionPreference = 'silentlycontinue'
$Authservice = @{
    User = admin@t-a9.org
    Password = admin
}
$remotehost = Invoke-WebRequest -Uri 'http://localhost:5080/AuthenticationService/login' -Method POST -Body ($Authservice|ConvertTo-Json) -ContentType "application/json" -UseBasicParsing -Method Head
$port = 25 
$ServiceName = "ServiceName"
$EmailFrom = "10.100.102.32@ta9ServiceHost.com"
$EmailTo = "YourEmailAddress" 
$SMTPServer = "smtp.office365.com" 
$SMTPAuthUser = "YourEmailAddress"
$SMTPAuthPass = "YourPassword"


# If connection refused, wait X seconds and try again
if($remotehost -eq $null) { 
	Start-Sleep -seconds 3
	$socket = new-object System.Net.Sockets.TcpClient($remoteHost) 

	# If connection refused, wait X seconds and try again
	if($remotehost -eq $null) { 
		Start-Sleep -seconds 3
		$socket = new-object System.Net.Sockets.TcpClient($remoteHost) 

		# If connection refused, restart ta9 service and send notification about restart
		if($remotehost -eq $null) { 
			Restart-Service $ServiceName
			# Send Notification via 365
				$Subject = "Windows Service Failure" 
				$Body = "ATTENTION! MyServer reporting that the TA9 service is being RESTARTED due to a fault. Check status NOW." 
				$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
				$SMTPClient.EnableSsl = $true 
				$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPAuthUser, $SMTPAuthPass); 
				$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)

			# Wait X seconds, check status of service - if not running, give up trying and send notification re service fault
			Start-Sleep -seconds 3
			(get-service $ServiceName).Refresh()
			if ((get-service $ServiceName).Status -ne 'Running')
			{
			# Send Notification via 365
				$Subject = "Windows Service Failure" 
				$Body = "ATTENTION! MyServer reporting that the TA9 service is not running. Check status NOW." 
				$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
				$SMTPClient.EnableSsl = $true 
				$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPAuthUser, $SMTPAuthPass); 
				$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)

			}
		}
	}
}
