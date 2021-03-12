#!/bin/bash
mkdir -p /backups/daily/
cp /backups/hourly/`ls -1 | tail -n 1` /backups/daily/
