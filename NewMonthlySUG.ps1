$scriptPath = 'R:\Workspace\Software Updates'
if ((Test-Path P01:) -ne $true) { 
	Connect-ConfigMgr
}

pushd P01:

$lastMonth = "Workstation - 1711"
$thisMonth = "Workstation - 1712"
$bacsug = "Workstation - OSD Only Deployment"
$baselinesug = "Workstation - Baseline"
$exclusionsug = "Workstation - Exclusions"

# MONTHLY PATCHING
# Get all patches in Monthly SUG
$monthly = Get-CMSoftwareUpdateGroup -Name $lastMonth
$totalMonthly = $monthly.Updates.Count
Write-Host Monthly: $totalMonthly
# Get baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name $baselinesug
Write-Host "Baseline (before):" $baseline.Updates.Count
# Get ADR SUG
$testing = Get-CMSoftwareUpdateGroup -Name "Workstation - 1 - Patch Testing"
Write-Host Testing: $testing.Updates.Count
# Add updates from monthly SUG to baseline
$i = 1
foreach ($update in $monthly.Updates) 
{ 
    $progress = [Int32](($i / $totalMonthly) * 100)
    Write-Progress -Activity "Adding Previous Months Updates to $baselinesug ($i/$totalMonthly)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $baselinesug -SoftwareUpdateId $update 
    $i++
}
Write-Progress -Activity "Adding Previous Months Updates to $baselinesug" -Completed
# Delete Monthly SUG
#Remove-CMSoftwareUpdateGroup -Name "Workstation - Monthly" -Force
# Remove Deployments from Previous Monthly SUG
Get-CMDeployment -SoftwareName $lastMonth | Remove-CMDeployment -Force
# Remove expired updates from baseline SUG
Write-Host Removing expired updates from $baselinesug
pushd $scriptPath
iex "& `"$scriptPath\Clean-CMSoftwareUpdateGroup.ps1`" -SiteServer CPTPRDMCM105 -SUGName `"$baselinesug`" -ExpiredOnly"
popd
# Get updated baseline SUG
$baseline = Get-CMSoftwareUpdateGroup -Name $baselinesug
Write-Host "$baselinesug (after):" $baseline.Updates.Count
$exclusions = Get-CMSoftwareUpdateGroup -Name $exclusionsug
Write-Host "$exclusionsug :" $exclusions.Updates.Count
# Get all patches in ADR and remove any patches that are in the baseline SUG (ie. already deployed) and exclusions SUG (ie. not to be deployed)
$newupdates = $testing.Updates | Where-Object {$baseline.updates -NotContains $_} | Where-Object {$exclusions.updates -NotContains $_}
$totalNew = $newupdates.Count
Write-Host New Updates: $totalNew
# Create new Monthly SUG
New-CMSoftwareUpdateGroup -Name $thisMonth
$i = 1
foreach ($update in $newupdates) 
{
    $progress = [Int32](($i / $totalNew) * 100)
    Write-Progress -Activity "Adding Updates to $thisMonth ($i/$totalNew)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $thisMonth -SoftwareUpdateId $update
    $i++
}
Write-Progress -Activity "Adding Updates to $thisMonth" -Completed
$monthly = Get-CMSoftwareUpdateGroup -Name $thisMonth
Write-Host "$thisMonth (new):" $monthly.NumberOfUpdates
#BUILD AND CAPTURE SUG
# Remove expired and superseded patches from build and capture SUG
Write-Host Removing expired and superseded updates from $bacsug
pushd $scriptPath
iex "& `"$scriptPath\Clean-CMSoftwareUpdateGroup.ps1`" -SiteServer CPTPRDMCM105 -SUGName `"$bacsug`""
popd
$bac = Get-CMSoftwareUpdateGroup -Name $bacsug
Write-Host "$bacsug (before):" $bac.NumberOfUpdates
$doubletrouble = Get-CMSoftwareUpdateGroup -Name "$bacsug - Exclusions"
Write-Host "$bacsug - Exclusions:" $doubletrouble.NumberOfUpdates
$updatestoadd = $baseline.Updates + $monthly.Updates | ? {$bac.updates -notcontains $_} | ? {$doubletrouble.updates -notcontains $_}
$totalNew = $updatestoadd.Count
$i = 1
foreach ($update in $updatestoadd) 
{
    $progress = [Int32](($i / $totalNew) * 100)
    Write-Progress -Activity "Adding Updates to the Build and Capture SUG ($i/$totalNew)" -PercentComplete $progress
    Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName $bacsug -SoftwareUpdateId $update
    $i++
}
Write-Progress -Activity "Adding Updates to $bacsug" -Completed
# Get updated build and capture sug
$bac = Get-CMSoftwareUpdateGroup -Name $bacsug
Write-Host "$bacsug (after):" $bac.NumberOfUpdates
popd