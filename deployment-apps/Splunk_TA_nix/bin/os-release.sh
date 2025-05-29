#!/bin/sh

if [ -f /etc/os-release ]; then
    . /etc/os-release
   
    printf '{
      "os_name": "%s",
	  "os_version": "%s",
	  "pretty_name": "%s",
	  "version_id": "%s",
	  "version": "%s"
    }\n' "$NAME" "$VERSION" "$PRETTY_NAME" "$VERSION_ID" "$VERSION"
else
    exit 1
fi