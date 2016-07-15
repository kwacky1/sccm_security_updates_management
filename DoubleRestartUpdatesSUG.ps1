﻿#https://support.microsoft.com/en-us/kb/2894518
$updates = 3126446,3096053,3075222,3067904,3069762,3003729,3035017,3039976,3036493,3003743,2984976,2981685,2966034,2965788,2920189,2862330,2871777,2871690,2821895,2771431,2545698,2529073
$updates | % {get-cmsoftwareupdate -articleid $_ | ? { ($_.IsExpired -eq $false) -and ($_.NumMissing -gt 0) } | Add-CMSoftwareUpdateToGroup -SoftwareUpdateGroupName "Double Restart Updates" }