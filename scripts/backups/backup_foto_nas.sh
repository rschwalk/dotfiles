#!/bin/bash
rsync -aP --delete --exclude-from=/home/rschwalk/dotfiles/scripts/backups/rsync_foto_excludes ssh /run/media/rschwalk/Data01/Foto/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/Foto
