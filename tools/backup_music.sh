#!/bin/bash
rsync -aP --delete ssh /run/media/rschwalk/Data01/Music/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/Music
