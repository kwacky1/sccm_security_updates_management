$availableToPilot = Get-Date 2016/03/13              # Sunday after Patch Tuesday
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

$pilot = Start-CMSoftwareUpdateDeployment -CollectionName "Workstation - 2 - Pilot" -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToPilot.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "Workstation - 2 - Pilot - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForPilot.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName "Workstation - 3 - Regional - Primary" -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToRegion1.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "Workstation - 3 - Regional - Primary - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion1.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName "Workstation - 4 - Regional - Secondary" -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToRegion2.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "Workstation - 4 - Regional - Secondary - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion2.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName "Workstation - 5 - CBD - Primary" -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToCBD.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "Workstation - 5 - CBD - Primary - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $availableToCBD.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName "All Workstations" -SoftwareUpdateGroupName "Workstation - Monthly" -DeploymentAvailableDay $availableToAll.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "Workstation - 6 - All Workstations - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForAll.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $False -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages

Write-Host DeploymentID for Runsheet is $pilot.DeploymentID
popd