# Installs PASM, sets Server, and Restarts Service
# Created by Sam Adams for PEAKE Technology Partners

# Downloads PASM Satellite App from Azure Blob
$url = "https://peakestorage1.blob.core.windows.net/automationcontainer/PPCv2/PASM/Setup.exe"
$outFile = "C:\Setup.exe"
(new-object Net.WebClient).DownloadFile($url, $outFile)

# Installs PASM Satellite 
C:\Setup.exe /SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /TYPE=satellite /TASKS="desktopicon,!nacli"

# Sets Server
Set-ItemProperty -Path "HKLM:\SOFTWARE\PAServerMonitor" -Name "ServiceHostName" -Value "pasm.peaketechnology.com" -Type "String"

# Restarts PASM Satellite 
net stop "PA Server Monitor Satellite"

net start "PA Server Monitor Satellite"

