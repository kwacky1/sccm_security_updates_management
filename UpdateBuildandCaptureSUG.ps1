$scriptPath = 'R:\Workspace\Software Updates'
if ((Test-Path P01:) -ne $true) { 
	Connect-ConfigMgr
}

pushd P01:

# Get all patches in Monthly SUG
$monthly = Get-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
$totalMonthly = $monthly.Updates.Count
Write-Host Monthly: $totalMonthly
# Get baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name "Workstation - Baseline"
Write-Host "Baseline (before):" $baseline.Updates.Count
# Get ADR SUG
$testing = Get-CMSoftwareUpdateGroup -Name "Workstation - 1 - Patch Testing"
Write-Host Testing: $testing.Updates.Count
# Add updates from monthly SUG to baseline
$i = 1
foreach ($update in $monthly.Updates) 
{ 
    $progress = [Int32](($i / $totalMonthly) * 100)
    Write-Progress -Activity "Adding Previous Months Updates to Baseline" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Baseline" -SoftwareUpdateId $update 
    $i++
}
# Delete Monthly SUG
Remove-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
# Remove expired and superseded patches from baseline SUG
& $scriptPath + '\Clean-CMSoftwareUpdateGroup.ps1' -SiteServer CPTPRDMCM105 -SUGName "Workstation - Baseline" -Verbose
# Get updated baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name "Workstation - Baseline"
Write-Host "Baseline (after):" $baseline.Updates.Count
$exclusions = Get-CMSoftwareUpdateGroup -Name "Workstation - Exclusions"
Write-Host "Exclusions:" $exclusions.Updates.Count
# Get all patches in ADR and remove any patches that are in the baseline SUG (ie. already deployed) and exclusions SUG (ie. not to be deployed)
$newupdates = $testing.Updates | Where-Object {$baseline.updates -NotContains $_} | Where-Object {$exclusions.updates -NotContains $_}
$totalNew = $newupdates.Count
Write-Host New Updates: $totalNew
# Create new Monthly SUG
New-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
$i = 1
foreach ($update in $newupdates) 
{
    $progress = [Int32](($i / $totalNew) * 100)
    Write-Progress -Activity "Adding Previous Months Updates to Baseline" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Monthly" -SoftwareUpdateId $update
    $i++
}
popd