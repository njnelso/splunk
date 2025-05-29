get-ADComputer -Filter * -prop Name, Enabled, Created, LockedOut, OperatingSystem, CanonicalName,  IPv4address, DNSHostName | select Name, Enabled, Created, LockedOut, OperatingSystem, CanonicalName,  IPv4address, DNSHostName | ConvertTo-Json

