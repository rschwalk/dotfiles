#!/bin/bash
rsync -ritvzls --progress --delete -b --backup-dir=_bu --exclude-from=/home/rschwalk/dotfiles/tools/rsync_sonst_excludes /run/media/rschwalk/Data01/Foto/sonst/ /run/user/1000/gvfs/smb-share:server=mybooklive,share=foto/richard/sonst
