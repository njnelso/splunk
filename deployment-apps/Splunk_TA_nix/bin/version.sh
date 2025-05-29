#!/bin/bash                                                                                               
# This is mine now. -Nick (02 April 2025)                                                          

printf '{"machine_hardware_name":"%s","machine_architecture_name":"%s","os_release":"%s","os_name":"%s","os_version":"%s"}\n' \
"$(uname -m)" "$(uname -p 2>/dev/null || uname -m)" "$(uname -r)" "$(uname -s)" "$(uname -v)"