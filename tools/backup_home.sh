#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/tools/rsync_home_excludes /home/rschwalk/ /run/media/rschwalk/Data02/backups/OpenSuse_Spectre
