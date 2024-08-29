# Define the snapshot naming convention
$SnapshotPrefix = "AutoSnapshot_"
$RetentionCount = 5
$Date = Get-Date -Format "yyyyMMdd_HHmmss"

# Get the list of all VMs on the host
$VMs = Get-VM

foreach ($VM in $VMs) {
    # Define the snapshot name
    $SnapshotName = "$SnapshotPrefix$($VM.Name)_$Date"

    # Create a new snapshot
    Checkpoint-VM -VMName $VM.Name -SnapshotName $SnapshotName -Description "Automated snapshot created on $Date"

    # Get a list of snapshots created by this script
    $Snapshots = Get-VMSnapshot -VMName $VM.Name | Where-Object { $_.Name -like "$SnapshotPrefix*" }

    # Sort snapshots by creation date
    $Snapshots = $Snapshots | Sort-Object CreationTime -Descending

    # Check if the number of snapshots exceeds the retention count
    if ($Snapshots.Count -gt $RetentionCount) {
        # Get the oldest snapshot(s) beyond the retention count
        $SnapshotsToDelete = $Snapshots | Select-Object -Skip $RetentionCount

        # Delete the oldest snapshot(s)
        foreach ($Snapshot in $SnapshotsToDelete) {
            Remove-VMSnapshot -VMName $VM.Name -Name $Snapshot.Name
        }
    }
}

