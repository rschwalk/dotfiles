#!/bin/bash
rsync -aP --delete ssh /run/media/rschwalk/Data01/Video/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/Video
