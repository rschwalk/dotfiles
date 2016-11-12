#!/bin/bash
rsync -r -v --progress --delete -l -s --exclude-from=/home/rschwalk/tools/rsync_foto_excludes /run/media/rschwalk/Data01/Foto/ /mnt/mybook_foto/richard
