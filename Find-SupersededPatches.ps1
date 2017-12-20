$CMPSSuppressFastNotUsedCheck = $true

$sep = "/DesiredConfigurationDigest>"
If (($patch.SDMPackageXML -split $sep | Measure-Object | Select-Object -Exp Count) -eq 2) {
    $a, $b = $patch.SDMPackageXML -split $sep
    $a += $sep
    $b += $sep
} else {
    $a = $patch.SDMPackageXML -split $sep
    $a += $sep
    $b = ""
}
[xml]$a
if ($b -ne "") { [xml]$b }

(([xml]($a + $sep)).DesiredConfigurationDigest.SoftwareUpdateBundle.SupersededUpdates.ChildNodes).LogicalName | % { $p = $_;Get-CMSoftwareUpdate | ? $_.ModelName -eq "Site_1FFADDC7-A4A8-4099-9845-13B1DCD8FBB8/$p"}


$CMPSSuppressFastNotUsedCheck = $false