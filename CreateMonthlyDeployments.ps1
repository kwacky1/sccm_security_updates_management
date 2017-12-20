# kick off date
$availableToPilot = Get-Date "2017/12/20 22:00"       # Sunday after Patch Tuesday
# applications
$monthlyDeployment = "Workstation - 1712"
$chromeDeployment = "Google Chrome 63.0.3239.108"
$firefoxDeployment = "Mozilla Firefox 57.0.2"
#$airDeployment = "Adobe AIR 25.0.0.134"
#$shockwaveDeployment = "Adobe Shockwave Player 12.3.1.201"
#$citrixDeployment = "Citrix Receiver 4.7"
#$deploymentName = "Microsoft Office 2013 Telemetry Agent (x64)"
# collections
$collPilot = "Workstation - 2 - Pilot"
$collICT = "Workstation - 2.5 - ICT"
$collRegion1 = "Workstation - 3 - Regional MPLS"
$collRegion2 = "Workstation - 4 - Suburban MPLS"
$collCBD = "Workstation - 5 - CBD - Primary"
$collAll = "Workstation - 6 - All Workstations"
$deadlineForPilot = $availableToPilot.AddDays(1)
$deploymentTime = '22:00:00'

<#Standard Schedule
$availableToICT = $availableToPilot.AddDays(10)      # Thursday after pilot (Post CAB)
$deadlineForICT = $availableToICT.AddDays(1)         # 24 Hours to install updates - Forced Reboot
$availableToRegion1 = $availableToICT.AddDays(4)     # Monday after ICT
$deadlineForRegion1 = $availableToRegion1.AddDays(1) # 24 Hours to install updates
$availableToRegion2 = $availableToRegion1.AddDays(1) # One day after region1
$deadlineForRegion2 = $availableToRegion2.AddDays(1) # 24 Hours to install updates
$availableToCBD = $availableToRegion2.AddDays(1)     # One day after region2
$deadlineForCBD = $availableToCBD.AddDays(1)         # 24 Hours to install updates
$availableToAll = $availableToCBD.AddDays(1)         # One day after CBD
$deadlineForAll = $availableToAll.AddDays(1)         # 24 Hours to install updates - Forced Reboot
$deadlineForAllUsers = $deadlineForAll.AddHours(-10) # -10 Hours for UTC based user deployments
#>
#Custom Schedule
$availableToICT = Get-Date "2018/01/10 22:00"        # Thursday after pilot (Post CAB)
$deadlineForICT = $availableToICT.AddDays(1)         # 24 Hours to install updates - Forced Reboot
$availableToRegion1 = $availableToICT.AddDays(4)     # Monday after ICT
$deadlineForRegion1 = $availableToRegion1.AddDays(1) # 24 Hours to install updates
$availableToRegion2 = $availableToRegion1.AddDays(1) # One day after region1
$deadlineForRegion2 = $availableToRegion2.AddDays(1) # 24 Hours to install updates
$availableToCBD = $availableToRegion2.AddDays(1)     # One day after region2
$deadlineForCBD = $availableToCBD.AddDays(1)         # 24 Hours to install updates
$availableToAll = $availableToCBD.AddDays(1)         # One day after CBD
$deadlineForAll = $availableToAll.AddDays(1)         # 24 Hours to install updates - Forced Reboot
$deadlineForAllUsers = $deadlineForAll.AddHours(-10) # -10 Hours for UTC based user deployments
#>
<#Emergency Schedule
$availableToRegion1 = $availableToPilot.AddDays(0)   # One week after pilot
$deadlineForRegion1 = $availableToRegion1.AddDays(1) # 24 Hours to install updates
$availableToRegion2 = $availableToRegion1.AddDays(1) # One day after region1
$deadlineForRegion2 = $availableToRegion2.AddDays(1) # 24 Hours to install updates
$availableToCBD = $availableToRegion2.AddDays(1)     # One day after region2
$deadlineForCBD = $availableToCBD.AddDays(1)         # 24 Hours to install updates
$availableToAll = $availableToCBD.AddDays(0)         # Sunday after
$deadlineForAll = $availableToAll.AddDays(1)         # 4 Days to install updates - Forced Reboot on the Thursday Night
#>
pushd P01:

#Monthly Updates
Start-CMSoftwareUpdateDeployment -CollectionName $collPilot -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToPilot.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collPilot - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForPilot.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collICT -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToICT.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collICT - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForICT.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $False -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collRegion1 -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToRegion1.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collRegion1 - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion1.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collRegion2 -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToRegion2.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collRegion2 - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForRegion2.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collCBD -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToCBD.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collCBD - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForCBD.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $True -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
Start-CMSoftwareUpdateDeployment -CollectionName $collAll -SoftwareUpdateGroupName $monthlyDeployment -DeploymentAvailableDay $availableToAll.ToString("yyyy/MM/d") -DeploymentAvailableTime $deploymentTime -DeploymentName "$collAll - Monthly" -DeploymentType Required -EnforcementDeadline $deploymentTime -EnforcementDeadlineDay $deadlineForAll.ToString("yyyy/MM/d") -PersistOnWriteFilterDevice $True -RestartServer $True -RestartWorkstation $False -SendWakeupPacket $True -TimeBasedOn LocalTime -UseBranchCache $True -UserNotification DisplayAll -VerbosityLevel OnlySuccessAndErrorMessages
#>
#Chrome
Start-CMApplicationDeployment -CollectionName "Google Chrome - 2 - Pilot" -Name $chromeDeployment -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Google Chrome - 2.5 - ICT" -Name $chromeDeployment -AvailableDateTime $availableToICT.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForICT.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Google Chrome - 3 - Regional MPLS" -Name $chromeDeployment -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Google Chrome - 4 - Suburban MPLS" -Name $chromeDeployment -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Google Chrome - 5 - CBD - Primary" -Name $chromeDeployment -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "All Workstations with Google Chrome" -Name $chromeDeployment -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Google_Chrome-WG" -Name $chromeDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm")
Start-CMApplicationDeployment -CollectionName "Google_Chrome-UG" -Name $chromeDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAllUsers.ToString("yyyy/MM/d HH:mm")
#>
#Firefox
Start-CMApplicationDeployment -CollectionName "Mozilla Firefox - 2 - Pilot" -Name $firefoxDeployment -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Mozilla Firefox - 2.5 - ICT" -Name $firefoxDeployment -AvailableDateTime $availableToICT.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForICT.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#Start-CMApplicationDeployment -CollectionName "Mozilla Firefox - 3 - Regional MPLS" -Name $firefoxDeployment -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#Start-CMApplicationDeployment -CollectionName "Mozilla Firefox - 4 - Suburban MPLS" -Name $firefoxDeployment -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#Start-CMApplicationDeployment -CollectionName "Mozilla Firefox - 5 - CBD - Primary" -Name $firefoxDeployment -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "All Workstations with Mozilla Firefox" -Name $firefoxDeployment -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Mozilla_Firefox-WG" -Name $firefoxDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm")
Start-CMApplicationDeployment -CollectionName "Mozilla_Firefox-UG" -Name $firefoxDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAllUsers.ToString("yyyy/MM/d HH:mm")
#>
<#Citrix Receiver
Start-CMApplicationDeployment -CollectionName "Citrix Receiver - 2 - Pilot" -Name $citrixDeployment -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Citrix Receiver - 2.5 - ICT" -Name $citrixDeployment -AvailableDateTime $availableToICT.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForICT.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Citrix Receiver - 3 - Regional MPLS" -Name $citrixDeployment -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Citrix Receiver - 4 - Suburban MPLS" -Name $citrixDeployment -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Citrix Receiver - 5 - CBD - Primary" -Name $citrixDeployment -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "All Workstations with Citrix Receiver" -Name $citrixDeployment -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Citrix_Receiver-WG" -Name $citrixDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm")
Start-CMApplicationDeployment -CollectionName "Citrix_Receiver-UG" -Name $citrixDeployment -DeployAction Install -DeployPurpose Available -AvailableDateTime $deadlineForAllUsers.ToString("yyyy/MM/d HH:mm")
#>
<#Adobe AIR
Start-CMApplicationDeployment -CollectionName "Adobe AIR - 2 - Pilot" -Name $airDeployment -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe AIR - 3 - Regional MPLS" -Name $airDeployment -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe AIR - 4 - Suburban MPLS" -Name $airDeployment -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe AIR - 5 - CBD - Primary" -Name $airDeployment -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "All Workstations with Adobe AIR" -Name $airDeployment -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#>
<#Adobe Shockwave
Start-CMApplicationDeployment -CollectionName "Adobe Shockwave - 2 - Pilot" -Name $shockwaveDeployment -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe Shockwave - 2.5 - ICT" -Name $shockwaveDeployment -AvailableDateTime $availableToICT.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForICT.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe Shockwave - 3 - Regional MPLS" -Name $shockwaveDeployment -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe Shockwave - 4 - Suburban MPLS" -Name $shockwaveDeployment -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "Adobe Shockwave - 5 - CBD - Primary" -Name $shockwaveDeployment -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName "All Workstations with Adobe Shockwave" -Name $shockwaveDeployment -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#>
<#One Off Deployment
Start-CMApplicationDeployment -CollectionName $collPilot -Name $deploymentName -AvailableDateTime $availableToPilot.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForPilot.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName $collICT -Name $deploymentName -AvailableDateTime $availableToICT.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForICT.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName $collRegion1 -Name $deploymentName -AvailableDateTime $availableToRegion1.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion1.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName $collRegion2 -Name $deploymentName -AvailableDateTime $availableToRegion2.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForRegion2.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName $collCBD -Name $deploymentName -AvailableDateTime $availableToCBD.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForCBD.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
Start-CMApplicationDeployment -CollectionName $collAll -Name $deploymentName -AvailableDateTime $availableToAll.ToString("yyyy/MM/d HH:mm") -DeadlineDateTime $deadlineForAll.ToString("yyyy/MM/d HH:mm") -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required 
#>

Write-Host $collPilot DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collPilot -SoftwareName $monthlyDeployment).AssignmentID
Write-Host $collICT DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collICT -SoftwareName $monthlyDeployment).AssignmentID
Write-Host $collRegion1 DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collRegion1 -SoftwareName $monthlyDeployment).AssignmentID
Write-Host $collRegion2 DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collRegion2 -SoftwareName $monthlyDeployment).AssignmentID
Write-Host $collCBD DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collCBD -SoftwareName $monthlyDeployment).AssignmentID
Write-Host $collAll DeploymentID for Runsheet is (Get-CMDeployment -CollectionName $collAll -SoftwareName $monthlyDeployment).AssignmentID

popd