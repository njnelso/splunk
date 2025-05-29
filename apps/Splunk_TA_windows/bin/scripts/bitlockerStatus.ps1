$computers = Get-ADComputer -Filter {OperatingSystem -like "Windows"} | Select-Object -ExpandProperty Name
foreach ($computer in $computers) {
    $bdeStatus = Manage-BDE -Status -ComputerName $computer

    # Split each section of the BDE status output and match them line by line
    $volumes = $bdeStatus | Select-String 'Volume\s(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    $conversionStatus = $bdeStatus | Select-String 'Conversion Status:\s(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    $protectionStatus = $bdeStatus | Select-String 'Protection Status:\s(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    $lockStatus = $bdeStatus | Select-String 'Lock Status:\s(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    $encryptionMethod = $bdeStatus | Select-String 'Encryption Method:\s(.*)' | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }

    # Ensure that we loop over volumes and align each property with it
    for ($i = 0; $i -lt $volumes.Count; $i++) {
        $output = [PSCustomObject]@{
            ComputerName      = $computer
            Volume            = $volumes[$i]
            ConversionStatus  = $conversionStatus[$i]
            ProtectionStatus  = $protectionStatus[$i]
            LockStatus        = $lockStatus[$i]
            EncryptionMethod  = $encryptionMethod[$i]
        }

        # Output the structured result (JSON format or CSV)
        $output | ConvertTo-Json -Compress
    }
}

