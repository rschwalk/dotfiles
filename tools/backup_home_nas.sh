#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/tools/rsync_home_excludes ssh /home/rschwalk/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/backups/OpenSuse_Spectre/
