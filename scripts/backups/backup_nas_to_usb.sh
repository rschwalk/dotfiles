#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/scripts/backups/rsync_nas_excludes -e ssh rschwalk@192.168.178.3:/volume1/Richard/ /run/media/rschwalk/Data01
