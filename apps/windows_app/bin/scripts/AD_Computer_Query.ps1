get-ADComputer -Filter {Enabled -eq $TRUE} -prop Name, IPv4address | select Name, IPv4address | ConvertTo-Json

