#!/bin/bash
echo "######################################################"
echo "                  Photo USB                           "
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_photo_usb.sh;
echo "######################################################"
echo "                  Photo NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_photo_nas.sh;
echo "######################################################"
echo "                  Video USB"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_video_usb.sh;
echo "######################################################"
echo "                  Video NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_video_nas.sh;
echo "######################################################"
echo "                  Music NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_music_nas.sh;
echo "######################################################"
echo "                 Foto Archive NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_foto_nas.sh;
echo "######################################################"
echo "                  home NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_home_nas.sh;
echo "######################################################"
echo "                  Sonst NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_sonst_nas.sh;
echo "######################################################"
echo "                  Spi NAS"
echo "######################################################"
/home/rschwalk/dotfiles/scripts/backups/backup_spi_nas.sh;