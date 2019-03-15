#!/bin/bash
rsync -aP --delete -e ssh /run/media/rschwalk/Data02/photography/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/photography
