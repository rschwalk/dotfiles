#!/bin/bash
rsync -aP --delete -e ssh /run/media/rschwalk/Data01/Foto/sonst/spi/ rschwalk@vrnas:/srv/dev-disk-by-label-NAS01/richard/Foto/sonst/spi
