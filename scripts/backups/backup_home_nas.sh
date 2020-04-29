#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/scripts/backups/rsync_home_excludes -e ssh /home/rschwalk/ rschwalk@192.168.178.3:/volume1/Richard/backups/ryzen/
