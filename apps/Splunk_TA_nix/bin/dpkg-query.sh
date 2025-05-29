#!/bin/bash

dpkg-query -W -f='{"package":"${Package}","version":"${Version}","architecture":"${Architecture}","maintainer":"${Maintainer}", "origin":"${Origin}","priority":"${Priority}","essential":"${Essential}"}\n'