param (
    [Parameter(Mandatory = $true)]
    [string[]]$Packages,
    [Parameter(Mandatory = $false)]
    [string[]]$ExcludePackages = @(),
    [Parameter(Mandatory = $false)]
    [switch]$Unregister = $false
)

$baseRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore"

$allPackages = Get-AppxPackage -AllUsers | Select-Object PackageFullName, PackageFamilyName, PackageUserInformation, NonRemovable

foreach ($package in $Packages) {
    $filteredPackages = $allPackages | Where-Object { $_.PackageFullName -like "*$package*" }
    if ($ExcludePackages.Count -gt 0) {
        $filteredPackages = $filteredPackages | Where-Object {
            $fullPackageName = $_.PackageFullName
            -not ($ExcludePackages | Where-Object { $fullPackageName -like "*$_*" })
        }
    }

    foreach ($pkg in $filteredPackages) {
        $fullPackageName = $pkg.PackageFullName
        $packageFamilyName = $pkg.PackageFamilyName

        Write-Host "Removing package: $($fullPackageName)"

        $deprovisionedPath = "$baseRegistryPath\Deprovisioned\$packageFamilyName"
        if (-not (Test-Path -Path $deprovisionedPath)) {
            New-Item -Path $deprovisionedPath -Force
        }

        $inboxAppsPath = "$baseRegistryPath\InboxApplications\$fullPackageName"
        if (Test-Path $inboxAppsPath) {
            Remove-Item -Path $inboxAppsPath -Force
        }

        if ($pkg.NonRemovable -eq 1) {
            Set-NonRemovableAppsPolicy -Online -PackageFamilyName $packageFamilyName -NonRemovable 0
        }

        foreach ($userInfo in $pkg.PackageUserInformation) {
            $userSid = $userInfo.UserSecurityID.SID
            $endOfLifePath = "$baseRegistryPath\EndOfLife\$userSid\$fullPackageName"
            New-Item -Path $endOfLifePath -Force

            if ($Unregister) {
                Remove-AppxPackage -Package $fullPackageName -User $userSid -PreserveRoamableApplicationData
            } else {
                Remove-AppxPackage -Package $fullPackageName -User $userSid
            }
        }

        if ($Unregister) {
            Remove-AppxPackage -Package $fullPackageName -AllUsers -PreserveRoamableApplicationData
        } else {
            Remove-AppxPackage -Package $fullPackageName -AllUsers
        }
    }
}
