$servicename = '“BMC Patrol Agent”'

$list = get-content "C:\Users\Administrator.DEMO\Desktop\Serverlist.txt"

foreach ($server in $list) {

if (Get-Service $servicename -ErrorAction SilentlyContinue)

{

Write-Host "$servicename exists on $server and starting the service."

Start-Service -Name $servicename

}

else
{

Write-Host "$servicename doesn't exist on $server"

Test-NetConnection -ComputerName ‘tsscp-tsispa1.ss.sw.ericsson.se’ -InformationLevel "Detailed" -Port 3183 | Select-Object PingSucceeded

Write-Host "Unzip BMC Patrol Agent for Installation"

Expand-Archive -LiteralPath 'C:\Users\Administrator.DEMO\Desktop\BMC Patrol Agent.zip' -DestinationPath C:\Users\Administrator.DEMO\Desktop

Write-Host "Installing the BMC Patrol Agent"

Invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation='C:\Users\Administrator.DEMO\Desktop\RunSilentInstall.exe'}

start-process -FilePath "C:\Users\Administrator.DEMO\Desktop\RunSilentInstall.exe" -ArgumentList '/S' -Verb runas -Wait
}

}

