#!/bin/bash                                                                                                                                                        

CVD_FILE="/var/lib/clamav/main.cvd"

if [ -f "$CVD_FILE" ]; then
	printf '{"file": "%s","last_modified":"%s"}\n' "$CVD_FILE" "$(stat -c '%y' /var/lib/clamav/main.cvd)"
else
	printf '{"file": "AV Defs Not Found"}\n'
fi