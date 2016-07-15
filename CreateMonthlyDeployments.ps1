$availableToPilot = Get-Date 2016/06/19              # Sunday after Patch Tuesday
$collPilot = "Workstation - 2 - Pilot"
$collRegion1 = "Workstation - 3 - Regional MPLS"
$collRegion2 = "Workstation - 4 - Suburban MPLS"
$collCBD = "Workstation - 5 - CBD - Primary"
$collAll = "All Workstations"
$deadlineForPilot = $availableToPilot.AddDays(1)
$deploymentTime = '22:00:00'

$availableToRegion1 = $availableToPilot.AddDays(7)   # One week after pilot
$deadlineForRegion1 = $availableToRegion1.AddDays(1) # 24 Hours to install updates
$availableToRegion2 = $availableToRegion1.AddDays(1) # One day after region1
$deadlineForRegion2 = $availableToRegion2.AddDays(1) # 24 Hours to install updates
$availableToCBD = $availableToRegion2.AddDays(1)     # One day after region2
$deadlineForCBD = $availableToCBD.AddDays(1)         # 24 Hours to install updates
$availableToAll = $availableToCBD.AddDays(5)         # Sunday after
$deadlineForAll = $availableToAll.AddDays(4)         # 4 Days to install updates - Forced Reboot on the Thursday Night

pushd P01:

Start-CMSoftwareUpdateDeployment -CollectionName $collPilot -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToPilot.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collPilot - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForPilot.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collRegion1 -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToRegion1.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collRegion1 - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion1.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collRegion2 -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToRegion2.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collRegion2 - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion2.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collCBD -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToCBD.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collCBD - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForCBD.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collAll -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToAll.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collAll - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForAll.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $False -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages

Write-Host Pilot DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $colPilot -SoftwareName "Workstation - Monthly").AssignmentID
popd