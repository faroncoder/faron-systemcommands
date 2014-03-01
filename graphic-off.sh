#!/bin/bash
sudo cp -r bashing/dat/grub-tty.dat /etc/default/grub
sudo update-grub
echo "Grub Graphic OFF!"
sudo reboot
exit 0
