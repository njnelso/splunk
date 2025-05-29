$drives = Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $total = $_.Used + $_.Free
    if ($total -ne 0) {
        [PSCustomObject]@{
            Name       = $_.Name
            UsedGB     = [math]::Round($_.Used / 1GB, 2)
            FreeGB     = [math]::Round($_.Free / 1GB, 2)
            TotalGB    = [math]::Round(($_.Used + $_.Free) / 1GB, 2)
            UsedPct    = [math]::Round(($_.Used / ($_.Used + $_.Free)) * 100, 2)
        }
    }
}

$drives | ConvertTo-Json -Depth 2
