#!/bin/bash
rsync -rivzls --progress --delete -b --backup-dir=_bu --exclude-from=/home/rschwalk/dotfiles/tools/rsync_foto_excludes /run/media/rschwalk/Data01/Foto/ /mnt/mybook_foto/richard
