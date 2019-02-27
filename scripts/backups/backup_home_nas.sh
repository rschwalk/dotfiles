#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/scripts/backups/rsync_home_excludes ssh /home/rschwalk/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/backups/Fedora_Ryzen/
