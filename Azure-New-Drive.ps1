Param (
    [string]$adminUsername,
    [string]$adminPassword
 )

$DriveName = "ADDS"
$DriveLetter = "X"


New-StoragePool -FriendlyName "$DriveName" -PhysicalDisks (Get-PhysicalDisk -CanPool $true) -StorageSubSystemFriendlyName (Get-StorageSubSystem -FriendlyName *).FriendlyName
New-VirtualDisk -FriendlyName "$DriveName" -StoragePoolFriendlyName "$DriveName" -ProvisioningType Thin -ResiliencySettingName Simple -Size (Get-StoragePool -FriendlyName "$DriveName").Size 
Get-VirtualDisk  | Get-Disk |Initialize-Disk

Get-VirtualDisk  | Get-Disk |New-Partition -UseMaximumSize -DriveLetter $DriveLetter 

Get-Volume | where {$_.OperationalStatus -eq "unknown" -and $_.DriveType -eq "Fixed"}|Format-Volume -FileSystem NTFS -NewFileSystemLabel "$DriveName"





