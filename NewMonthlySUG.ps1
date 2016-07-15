$scriptPath = 'R:\Workspace\Software Updates'
if ((Test-Path P01:) -ne $true) { 
	Connect-ConfigMgr
}

pushd P01:

# MONTHLY PATCHING
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
    Write-Progress -Activity "Adding Previous Months Updates to Baseline ($i/$totalMonthly)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Baseline" -SoftwareUpdateId $update 
    $i++
}
# Delete Monthly SUG
Remove-CMSoftwareUpdateGroup -Name "Workstation - Monthly" -Force
# Remove expired and superseded patches from baseline SUG
pushd $scriptPath
iex "& `"$scriptPath\Clean-CMSoftwareUpdateGroup.ps1`" -SiteServer CPTPRDMCM105 -SUGName `"Workstation - Baseline`" -Verbose"
popd
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
    Write-Progress -Activity "Adding Updates to the new Monthly SUG ($i/$totalNew)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Workstation - Monthly" -SoftwareUpdateId $update
    $i++
}
$monthly = Get-CMSoftwareUpdateGroup -Name "Workstation - Monthly"
Write-Host "Monthly (new):" $monthly.NumberOfUpdates
#BUILD AND CAPTURE SUG
# Remove expired and superseded patches from baseline SUG
pushd $scriptPath
iex "& `"$scriptPath\Clean-CMSoftwareUpdateGroup.ps1`" -SiteServer CPTPRDMCM105 -SUGName `"Build and Capture Only Deployment`" -Verbose"
popd
$bac = Get-CMSoftwareUpdateGroup -Name "Build and Capture Only Deployment"
Write-Host "Build and Capture (before):" $bac.NumberOfUpdates
$doubletrouble = Get-CMSoftwareUpdateGroup -Name "Double Restart Updates"
Write-Host "Double Restart Updates:" $doubletrouble.NumberOfUpdates
$updatestoadd = $baseline.Updates + $monthly.Updates | ? {$bac.updates -notcontains $_} | ? {$doubletrouble.updates -notcontains $_}
$totalNew = $updatestoadd.Count
$i = 1
foreach ($update in $updatestoadd) 
{
    $progress = [Int32](($i / $totalNew) * 100)
    Write-Progress -Activity "Adding Updates to the Build and Capture SUG ($i/$totalNew)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Build and Capture Only Deployment" -SoftwareUpdateId $update
    $i++
}
# Get updated build and capture sug
$bac = Get-CMSoftwareUpdateGroup -Name "Build and Capture Only Deployment"
Write-Host "Build and Capture (after):" $bac.NumberOfUpdates
popd