#!/bin/bash
rsync -aP --delete  -e ssh /Volumes/Photos/ rschwalk@192.168.178.3:/volume1/Richard/photography/WIP
