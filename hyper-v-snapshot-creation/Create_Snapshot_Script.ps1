# Variables
$scriptUrl = "https://peakestorage1.blob.core.windows.net/automationcontainer/PPCv2/Hyper-V%20Snapshots/create_snapshots.ps1"
$scriptPath = "C:\IT\Hyper_V_Snapshots.ps1"
$taskName = "Daily Hyper-V Snapshot Rotation"

# Create the directory if it doesn't exist
if (-not (Test-Path "C:\IT")) {
    New-Item -Path "C:\IT" -ItemType Directory
}

# Download the script from the URL
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath

# Check if the script was downloaded successfully
if (-not (Test-Path $scriptPath)) {
    Write-Host "Failed to download the script." -ForegroundColor Red
    exit 1
}

# Remove any existing task with the same name
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

# Define the action (run the PowerShell script)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File `"$scriptPath`""

# Define the trigger (daily at midnight)
$trigger = New-ScheduledTaskTrigger -Daily -At "12:00AM"

# Create the scheduled task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description "Daily snapshot rotation for Hyper-V VMs" -User "SYSTEM" -RunLevel Highest

Write-Host "Script downloaded and scheduled task created successfully!" -ForegroundColor Green
