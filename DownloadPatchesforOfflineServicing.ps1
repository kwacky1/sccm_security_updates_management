#$SUGName = "Build and Capture Only Deployment"
#$SUGName = "Double Restart Updates"
$SUGName = "Workstation - Monthly"

#$missing = import-csv d:\temp\yay207updates.csv
pushd P01:
$missing = Get-CMSoftwareUpdateGroup -Name $SUGName

foreach ($updateid in $missing.Updates) 
{ 
    sl P01:
    write-host UpdateID: $updateid
    $cmupdate = Get-CMSoftwareUpdate -ID $updateid -Fast
    $displayName = ((([xml]$cmupdate.SDMPackageXML).DesiredConfigurationDigest).GetElementsByTagName('DisplayName')).Text.Replace("/","-")
    $version = (([xml]$cmupdate.SDMPackageXML).DesiredConfigurationDigest.FirstChild).Version
    write-host Display Name: $displayName
    write-host XML Version: $version
    #write-host SDMPackageXML: $cmupdate.SDMPackageXML
    if ($version -lt 200) 
    {
        $logicalname = ((([xml]$cmupdate.SDMPackageXML).DesiredConfigurationDigest).GetElementsByTagName('ConfigurationMetadata')).SmsUniqueIdentity
    } else {
        $logicalname = (([xml]$cmupdate.SDMPackageXML).DesiredConfigurationDigest.SoftwareUpdateBundle.Updates.SoftwareUpdateReference).LogicalName.Trim('SUM_')
    }
    $logicalname | % {
        write-host Logical Name: $_
        $contentdir = "\\sccm\datasources$\SofwareUpdates\*\$_\*"
        sl D:
        ls $contentdir | % { 
            if ((test-path "\\corp\file\Software\Utilities\Patch Frenzy\$displayName") -eq $false) { mkdir "\\corp\file\Software\Utilities\Patch Frenzy\$displayName" }
            cp $_.FullName -Destination "\\corp\file\Software\Utilities\Patch Frenzy\$displayName\"
        }
    }
}
popd