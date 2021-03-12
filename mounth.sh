#!/bin/bash
mkdir -p /backups/mounthly/
cp /backups/daily/`ls -1 | tail -n 1` /backups/mounthly/ || exit 1
rm -rf /backups/daily/`ls -1 | tail -n 1`

