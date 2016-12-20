#!/bin/bash
rsync -r -v --progress --delete -l -s --exclude-from=/home/rschwalk/tools/rsync_home_excludes /home/rschwalk /mnt/mybook_richard/bu_manjaro_env6
