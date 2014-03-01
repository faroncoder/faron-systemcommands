#!/bin/bash
sudo cp -r bashing/dat/grub-graphic.dat /etc/default/grub
sudo update-grub
echo "Grub Graphic ON!"
sudo reboot
exit 0
