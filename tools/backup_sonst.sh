#!/bin/bash
rsync -rivzls --progress --delete -b --backup-dir=_bu --exclude-from=/home/rschwalk/dotfiles/tools/rsync_sonst_excludes /run/media/rschwalk/Data01/Foto/sonst/ /mnt/mybook_foto/richard/sonst
