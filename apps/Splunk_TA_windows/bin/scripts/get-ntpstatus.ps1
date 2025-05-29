function Get-NtpStatus {
    $output = w32tm /query /status
    $timeData = @{}

    foreach ($line in $output) {
        if ($line -match '^([^:]+):\s*(.+)$') {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            $timeData[$key] = $value

        }
    }

    $timeObject = [PSCustomObject]@{
        NtpSource = $timeData["Source"]
        LastSyncTime = $timeData["Last Successful Sync Time"]
        PollInterval = $timeData["Poll Interval"]
    }

    return $timeObject
}

$timeInfo = Get-NtpStatus
$jsonOutput = $timeInfo | ConvertTo-Json
$jsonOutput
