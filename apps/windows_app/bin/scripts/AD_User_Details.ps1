
$properties = @(
    "Name",
    "SamAccountName",
    "Enabled",
    "LockedOut",
    "adminCount",
    "whenCreated",
    "msDS-FailedInteractiveLogonCount",
    "LastBadPasswordAttempt",
    "CanonicalName",
    "MemberOf",
    "ObjectSid",
    "PasswordNotRequired",
    "PasswordNeverExpires",
    "PasswordExpired",
    "PasswordLastSet",
    "Description"
)

Get-ADUser -Filter * -Properties $properties | Select $properties | ConvertTo-Json -Depth 1
