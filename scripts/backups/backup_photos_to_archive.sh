#!/bin/bash
rsync -aP --delete --progress --exclude '.*' /Volumes/Photos/ /Volumes/PhotosArchive1
