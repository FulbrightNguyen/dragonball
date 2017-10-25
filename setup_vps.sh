#!/bin/bash

# Set variables
# -----------------------------------
GUNBOT_GITHUB_FOLDER_NAME="Gunbot3.3.2"
GUNBOT_GITHUB_FILE_NAME="GUNBOT_v3.3.2_Poloniex_Bittrex_Patch"


# Set functions
# -----------------------------------
logMessage () {
  echo " $1"
  echo " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}


echo ""
echo " ============================================================"
echo "                    DRAGONBALL 0.0.2 SETUP started"
echo ""
echo "                This will take a few seconds"
echo ""
echo "                DEBUG VERSION WITH A LOT OF OUTPUT"
echo ""
echo " ============================================================"
echo ""

logMessage "(1/6) Update the base system"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
apt-get update


logMessage "(2/6) Install nodejs 6.x"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get -y install nodejs


logMessage "(3/6) Install tools"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
apt-get -y install unzip
npm install -g pm2 yo@1.8.5 generator-gunbot gunbot-monitor


logMessage "(4/6) Install GUNBOT"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
wget https://github.com/GuntharDeNiro/BTCT/releases/download/${GUNBOT_GITHUB_FOLDER_NAME}/${GUNBOT_GITHUB_FILE_NAME}.zip -P /opt/
unzip -o /opt/${GUNBOT_GITHUB_FILE_NAME}.zip -d /opt/unzip-tmp

# create folder for the current version.
mkdir /opt/${GUNBOT_GITHUB_FILE_NAME} -p

# Copy only the executables.
cp /opt/unzip-tmp/gunthy-* /opt/${GUNBOT_GITHUB_FILE_NAME}

# creates a symbolic link to the gunbot folder.
rm /opt/gunbot > /dev/null
ln -s /opt/${GUNBOT_GITHUB_FILE_NAME} /opt/gunbot

# Cleanup
rm /opt/${GUNBOT_GITHUB_FILE_NAME}.zip
rm -R /opt/unzip-tmp

# Set rights
chmod +x /opt/gunbot/gunthy-*



logMessage "(5/6) Add GUNBOT aliases"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "" >> ~/.bashrc
echo "# GUNBOT ALIASES" >> ~/.bashrc
echo "alias gcd='cd /opt/gunbot'" >> ~/.bashrc
echo "alias ginit='gcd && yo gunbot init'" >> ~/.bashrc
echo "alias gadd='gcd && yo gunbot add'" >> ~/.bashrc
echo "alias gl='pm2 l'" >> ~/.bashrc
echo "alias glog='pm2 logs'" >> ~/.bashrc
echo "alias gstart='pm2 start'" >> ~/.bashrc
echo "alias gstop='pm2 stop'" >> ~/.bashrc



logMessage "(6/6) Init generator"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create folder for yeoman.
chmod g+rwx /root
chmod g+rwx /opt/gunbot

# Yeoman write rights.
mkdir /root/.config/configstore -p
cat > /root/.config/configstore/insight-yo.json << EOM
{
        "clientId": 1337,
        "optOut": true
}
EOM
chmod g+rwx /root/.config
chmod g+rwx /root/.config/configstore
chmod g+rw /root/.config/configstore/*

# pm2 write rights.
mkdir /root/.pm2 -p
echo "1337" > /root/.pm2/touch
chmod g+rwx /root/.pm2
chmod g+rw /root/.pm2/*


echo ""
echo " ============================================================"
echo "                   DRAGONBALL SETUP complete!"
echo ""
echo "          Please run this command to init the GUNBOT:"
echo "                           gcd"
echo "                           ginit"
echo ""
echo " ============================================================"
echo ""

#Install some traffic exchange script on VPS ubuntu 16.04.

#- hitleap.com
#- kilohits.com
#- websyndic.com (Browser)
#- otohits.net (Need memory more than 1GB)

#Requirement
#- SSH client (port forwarding need) or Putty
#- VNC client

# Amazon Ec2: sudo su
#Install vncserver 
 apt update && apt upgrade -y && sudo apt install xfce4 xfce4-goodies tightvncserver -y

#On Vultr vps install font: apt-get install xfonts-base -y
 vncserver
 vncserver -kill :1
#Config xstartup
 mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
 nano ~/.vnc/xstartup
#Paste these commands
(Write under)
#!/bin/bash
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
autocutsel -fork
startxfce4 &

(End)

#Grant executable privileges
 sudo chmod +x ~/.vnc/xstartup
#Creating a VNC Service File
 sudo nano /etc/systemd/system/vncserver@.service
#Copy and paste the following into it
(Write under)

[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=root
PAMName=login
PIDFile=/home/root/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target

(End)

#Make the system aware of the new unit file
 sudo systemctl daemon-reload
 sudo systemctl enable vncserver@1
 sudo systemctl start vncserver@1

#Go to Desktop
 cd ~/Desktop/
# apt install unzip
#Download toolkit from github
#git init
 git clone https://github.com/nnquangminh/mmo.git
#git remote add origin https://github.com/nnquangminh/mmo.git
#git pull origin master
#Extract file
 tar Jxvf ~/Desktop/mmo/hit.tar.xz -C ~/Desktop/ && unzip ~/Desktop/mmo/kilohits.com-viewer-linux-x64.zip -d ~/Desktop/ && unzip ~/Desktop/mmo/OtohitsApp_3107_Linux.zip -d ~/Desktop/ && unzip ~/Desktop/mmo/crossover_13.1.3-1.zip -d ~/Desktop/mmo/ && unzip ~/Desktop/mmo/jingling.zip -d ~/Desktop/ && unzip ~/Desktop/mmo/traffic_spirit.zip -d ~/Desktop/
#or 
#Hitleap
# wget https://hitleap.com/viewer/download?platform=Linux -O hit.tar.xz && tar Jxvf hit.tar.xz
##or for vultr vps
# #wget https://www.dropbox.com/s/u1v0e91ofgh0mer/hit.tar.xz?dl=0 -O hit.tar.xz && tar Jxvf hit.tar.xz
#Kilohits
# wget https://www.dropbox.com/s/ytf7kwc1kiiclz9/kilohits.com-viewer-linux-x64.zip?dl=0 -O kilohits.com-viewer-linux-x64.zip && unzip kilohits.com-viewer-linux-x64.zip
#Otohits (Need 1GB memory)
# wget http://www.otohits.net/dl/OtohitsApp_3107_Linux.zip && unzip OtohitsApp_3107_Linux.zip

#Libnss3 (kilohits) libcurl3 (Otohits) firefox(websyndic)
 apt install libnss3 libcurl3 firefox -y
  
#Have the Hitleap, Kilohits, Otohits run when reboot:
 mkdir $HOME/.config/autostart
 sudo nano /usr/local/bin/autostart.sh
(Write under)
#!/bin/bash
export DISPLAY=:1 && ~/Desktop/OtohitsApp/./OtohitsApp | ~/Desktop/kilohits.com-viewer-linux-x64/./kilohits.com-viewer | (~/Desktop/app/./HitLeap-Viewer && wait)

(End)

 chmod ugo+x /usr/local/bin/autostart.sh
 sudo nano ~/.config/autostart/.desktop
(Write under)

[Desktop Entry]
Type=Application
Exec=/usr/local/bin/autostart.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Startup Script

(End)
 
 chmod ugo+x ~/.config/autostart/.desktop

#Next Install for Jingling & Traffic Spirit
#Install wine
#If have old wine version then run following command to remove
#sudo apt-get remove --purge wine-devel*
#sudo apt-get update
#sudo apt-get autoclean
#sudo apt-get clean
#sudo apt-get autoremove
 sudo dpkg --add-architecture i386
 sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
 wget https://dl.winehq.org/wine-builds/Release.key && sudo apt-key add Release.key
 sudo apt update && sudo apt install winehq-stable -y
#Install winetricks
 sudo apt-get install winetricks -y
#Install CrossOver
 sudo apt-get -f install
 sudo apt-get install gdebi -y
 apt-get install python-gtk2 -y
 sudo dpkg -i ~/Desktop/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
 sudo apt-get -f install
 sudo dpkg -i ~/Desktop/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
#To Reconfigure: sudo dpkg-reconfigure ~/Desktop/mmo/crossover_13.1.3-1/crossover_13.1.3-1.deb
#CRACK CrossOver by copy winewrapper.exe.so file to overwriting existing file in this dir: /opt/cxoffice/lib/wine
 cp -rf ~/Desktop/mmo/crossover_13.1.3-1/crack/winewrapper.exe.so /opt/cxoffice/lib/wine/
#Uninstall CrossOver: 
#sudo /opt/cxoffice/bin/cxuninstall
#cd ~/Desktop
#git clone https://github.com/nnquangminh/mmotoolkit.git
#Install copy/paste text from remote system
 sudo apt-get install autocutsel
#on Desktop screen, run terminal to create other prefix (e.g. : .wine32), set WINEARCH to win32 and run winecfg:
 WINEPREFIX="$HOME/.wine32" WINEARCH=win32 winecfg
 "Set Windows 7"
#Then run winetricks using the last configurations:
 WINEPREFIX="$HOME/.wine32" WINEARCH=win32 winetricks
#Copy gacutil-net40.tar.bz2 file from mmtoolkit dir to /root/.cache/winetricks/dotnet40/ ->rerun
#add ref link to jingling: 
 https://www.tumblr.com/
 https://plus.google.com/
 https://www.facebook.com/
#Task management
 apt install htop
#Generate a report of the network usage 
 apt-get install vnstat
#To monitor the bandwidth usage in realtime, use: vnstat -l -i eth0   
#Disable vps from going to sleep 
 sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
#Configure the network interface
 sudo nano /etc/network/interfaces
#Using nameservers 8.8.8.8 and 8.8.4.4 are provided by Google for public use -> dns-nameservers 8.8.8.8 8.8.4.4 ->  Type Ctrl+x to save changes.
#Manually restart your network interface with the new settings
 systemctl restart ifup@eth0
 /etc/init.d/networking restart
#Type the following commands to verify your new setup, enter:
 ifconfig eth0
 route -n
 ping google.com
 
 reboot
 
#Done!