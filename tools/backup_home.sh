#!/bin/bash
rsync -rivzls --progress --delete --exclude-from=/home/rschwalk/dotfiles/tools/rsync_home_excludes /home/rschwalk /run/media/Data01/Manjaro_Spectre
