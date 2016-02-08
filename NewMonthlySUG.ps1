if ((Test-Path P01:) -ne $true) { 
	Connect-ConfigMgr
}

Set-Location P01:

# Get all patches in Monthly SUG
$monthly = Get-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
Write-Host Monthly: $monthly.Updates.Count
# Get baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name "Workstation - Baseline"
Write-Host "Baseline (before):" $baseline.Updates.Count
# Get ADR SUG
$testing = Get-CMSoftwareUpdateGroup -Name "Workstation - 1 - Patch Testing"
Write-Host Testing: $testing.Updates.Count
# Add updates from monthly SUG to baseline
foreach ($update in $monthly.Updates) 
{ 
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Baseline" -SoftwareUpdateId $update 
    
}
# Delete Monthly SUG
Remove-CMSoftwareUpdateGroup -Name "Workstation - Monthly" -Confirm
# Remove expired and superseded patches from baseline SUG
.\Clean-CMSoftwareUpdateGroup.ps1 -SiteServer CPTPRDMCM105 -SUGName "Workstation - Baseline" -Verbose
# Get updated baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name "Workstation - Baseline"
Write-Host "Baseline (after):" $baseline.Updates.Count
# Get all patches in ADR and remove any patches that are in the baseline SUG (ie. already deploye) and exclusions SUG (ie. not to be deployed)
$newupdates = $testing.Updates | Where-Object {$baseline.updates -NotContains $_} | Where-Object {$exclusions.updates -NotContains $_}
Write-Host New Updates: $newupdates.Count
# Create new Monthly SUG
New-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
foreach ($update in $newupdates) {Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Monthly" -SoftwareUpdateId $update}