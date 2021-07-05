#!/bin/bash

dpkg --purge fahclient
dpkg -i --force-depends fahclient_7.5.1_amd64.deb

