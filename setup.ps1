# Run Hyper-V Snapshot Script
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/PEAKE-Technology-Partners/New_Server_Setup_Scripts/main/hyper-v-snapshot-creation/Create_Snapshot_Script.ps1'))

# Run PASM Setup Script
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/PEAKE-Technology-Partners/New_Server_Setup_Scripts/main/pasm-install/PASM_Install.ps1'))


# Run Timezone Script
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/PEAKE-Technology-Partners/New_Server_Setup_Scripts/main/timezone-config/change-timezone.ps1'))
