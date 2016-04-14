#flash

#newer version
[System.Version](Get-Item 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Adobe Flash Player ActiveX').GetValue('DisplayVersion') -ge [System.Version]"20.0.0.270"

#Missing
$objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = 'd443dc38-396a-4ed2-9738-8a4845d9a571'"
$cab = $objCache.Location+'\c2b79426-8fbc-4625-9168-58eaa0bda59f_1.cab'
(ls $cab).LastWriteTime.DateTime -eq 'Friday, 15 January 2016 10:09:46 AM'

#Installed
If ([System.Version](Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object DisplayName -like 'Adobe Flash Player * ActiveX').DisplayVersion -ge [System.Version]"20.0.0.270")  {
    #New version alredy present
    Return $true
} else {
    $objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = 'd443dc38-396a-4ed2-9738-8a4845d9a571'"
    if ($objCache) {
        $cab = $objCache.Location+'\c2b79426-8fbc-4625-9168-58eaa0bda59f_1.cab'
        If ((ls $cab -ErrorAction SilentlyContinue).LastWriteTime.DateTime -eq 'Thursday, 28 January 2016 11:53:59 AM') { 
            #Cache has the updated content
            Return $true 
        }
    } else {
    #No content in cache, so nothing to fix
    return $true
    }
}

#fix
powershell -noprofile -command "$objCache = Get-WmiObject -Namespace \"root\ccm\softmgmtagent\" -Query \"SELECT * FROM CacheInfoEx WHERE ContentID = 'd443dc38-396a-4ed2-9738-8a4845d9a571'\"; $objCache.Delete(); Remove-Item $objCache.Location -Recurse -Force"
 ([wmiclass]'ROOT\ccm:SMS_Client').TriggerSchedule('{00000000-0000-0000-0000-000000000113}')
 ([wmiclass]'ROOT\ccm:SMS_Client').TriggerSchedule('{00000000-0000-0000-0000-000000000108}')

#reader
#installed
(Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object DisplayName -eq 'Adobe Acrobat Reader DC').DisplayVersion

#Missing
$objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = 'd2b883f3-436f-4b90-8352-b55db66c335e'"
$cab = $objCache.Location+'\AcroRdrDCUpd1501020056.cab'
(ls $cab).LastWriteTime.DateTime -eq 'Thursday, 14 January 2016 3:04:22 PM'

#Installed
If ([System.Version](Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object DisplayName -eq 'Adobe Acrobat Reader DC').DisplayVersion -ge [System.Version]"15.010.20056") {
    #New version already installed
    Return $true
} else {
    $objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = 'd2b883f3-436f-4b90-8352-b55db66c335e'"
    if ( $objCache ) {
        $cab = $objCache.Location+'\AcroRdrDCUpd1501020056.cab'
        If ((ls $cab -ErrorAction SilentlyContinue).LastWriteTime.DateTime -eq 'Thursday, 28 January 2016 11:54:18 AM') { 
            #Cache has the updated content
            Return $true 
        }
    } else {
        #Nothing in cache, so nothing to fix
        Return $true
    }
}

#fix
powershell -noprofile -command "$objCache = Get-WmiObject -Namespace \"root\ccm\softmgmtagent\" -Query \"SELECT * FROM CacheInfoEx WHERE ContentID = 'd2b883f3-436f-4b90-8352-b55db66c335e'\"; if ($objCache) { $objCache.Delete(); Remove-Item $objCache.Location -Recurse -Force }"


#acrobat xi
# 4b2c0d89-fc21-4131-a53d-815dc1d4f0ae

#fix
powershell -noprofile -command "$objCache = Get-WmiObject -Namespace \"root\ccm\softmgmtagent\" -Query \"SELECT * FROM CacheInfoEx WHERE ContentID = '4b2c0d89-fc21-4131-a53d-815dc1d4f0ae' -ErrorAction SilentlyContinue\"; if ($objCache) { $objCache.Delete(); Remove-Item $objCache.Location -Recurse -Force }"

#detection
If ([System.Version](Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object DisplayName -eq 'Adobe Acrobat XI Standard').DisplayVersion -ge [System.Version]"11.0.14") {
    #New version already installed
    Return $true
} else {
    $objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = '4b2c0d89-fc21-4131-a53d-815dc1d4f0ae'"
    if ( $objCache ) {
        $cab = $objCache.Location+'\AcrobatUpd11014.cab'
        If ((ls $cab -ErrorAction SilentlyContinue).LastWriteTime.DateTime -eq 'Monday, 1 February 2016 1:58:08 PM') { 
            #Cache has the updated content
            Return $true 
        }
    } else {
        #Nothing in cache, so nothing to fix
        Return $true
    }
}

#flash plugin
# ca567910-9ea0-43a2-923a-a788161b0691

#fix
powershell -noprofile -command "$objCache = Get-WmiObject -Namespace \"root\ccm\softmgmtagent\" -Query \"SELECT * FROM CacheInfoEx WHERE ContentID = 'ca567910-9ea0-43a2-923a-a788161b0691' -ErrorAction SilentlyContinue\"; if ($objCache) { $objCache.Delete(); Remove-Item $objCache.Location -Recurse -Force }"

#detection
If ([System.Version](Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Where-Object DisplayName -like 'Adobe Flash Player * NPAPI').DisplayVersion -ge [System.Version]"20.0.0.267") {
    #New version already installed
    Return $true
} else {
    $objCache = Get-WmiObject -Namespace "root\ccm\softmgmtagent" -Query "SELECT * FROM CacheInfoEx WHERE ContentID = 'ca567910-9ea0-43a2-923a-a788161b0691'"
    if ( $objCache ) {
        $cab = $objCache.Location+'\9f2a0141-8d1d-4af3-8561-29bb0a1304a5_1.cab'
        If ((ls $cab -ErrorAction SilentlyContinue).LastWriteTime.DateTime -eq 'Thursday, 28 January 2016 11:53:51 AM') { 
            #Cache has the updated content
            Return $true 
        }
    } else {
        #Nothing in cache, so nothing to fix
        Return $true
    }
}
