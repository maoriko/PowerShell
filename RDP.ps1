<#
.Synopsis
Checks for and connects to RDP on a given server.
.Description
This script tests for an open port 3389 (standard Windows RDP), and if it finds it, passes the IP to mstsc.exe. Otherwise it retries indefinitely. Ctrl+C will halt the script.
.Parameter ip
IP or FQDN of a Windows machine to test. Only takes one argument.
.Parameter wait
Will assume that the machine is still up, wait until it stops responding (even once), and then try to connect. Good for machines that are about to reboot.
.Parameter Verbose
Will print a line each time it tries unsuccessfully.
.Example
rdpupyet.ps1 ITG-SRV-INF01 -Verbose
#>
[CmdletBinding()]
param($ip, [switch]$wait)

function Get-DownYet ($ip) {
    Write-Verbose "Waiting for $IP to shut down."
    do {
        try {$up = New-Object System.Net.Sockets.TCPClient -ArgumentList $ip,3389}
        catch {$up = $false}
    }
    until ($up -eq $false)
    Write-Verbose "$IP no longer responding."
}

Write-Verbose "Testing RDP Connection... Ctrl+C to quit."

if ($wait) {Get-DownYet $ip}
do {
    try {$success = New-Object System.Net.Sockets.TCPClient -ArgumentList $ip,3389}
    catch {Write-Verbose "RDP not active. Retrying."}
}
while (!$success)

mstsc.exe /v:$ip /admin