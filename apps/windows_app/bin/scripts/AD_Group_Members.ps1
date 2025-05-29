Get-ADGroup -Filter * | ForEach-Object {
    $groupInfo = @{
        GroupName = $_.Name
        GroupCategory = $_.GroupCategory.ToString()
        GroupScope = $_.GroupScope.ToString()
        Members = @(
            Get-ADGroupMember -Identity $_.DistinguishedName -ErrorAction SilentlyContinue | ForEach-Object {
                @{
                    Name = $_.Name
                    SamAccountName = $_.SamAccountName
                }
            }
        )
    }

    ConvertTo-Json -InputObject $groupInfo

}
