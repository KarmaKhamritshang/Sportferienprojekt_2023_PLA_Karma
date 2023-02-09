#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset
 
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
 
# Background
BG_Black='\033[40m'       # Black
BG_Red='\033[41m'         # Red
BG_Green='\033[42m'       # Green
BG_Yellow='\033[43m'      # Yellow
BG_Blue='\033[44m'        # Blue
BG_Purple='\033[45m'      # Purple
BG_Cyan='\033[46m'        # Cyan
BG_White='\033[47m'       # White
 
# High Intensity
HIBlack='\033[0;90m'       # Black
HIRed='\033[0;91m'         # Red
HIGreen='\033[0;92m'       # Green
HIYellow='\033[0;93m'      # Yellow
HIBlue='\033[0;94m'        # Blue
HIPurple='\033[0;95m'      # Purple
HICyan='\033[0;96m'        # Cyan
HIWhite='\033[0;97m'       # White
 
# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
 
# High Intensity backgrounds
BG_IBlack='\033[0;100m'   # Black
BG_IRed='\033[0;101m'     # Red
BG_IGreen='\033[0;102m'   # Green
BG_IYellow='\033[0;103m'  # Yellow
BG_IBlue='\033[0;104m'    # Blue
BG_IPurple='\033[0;105m'  # Purple
BG_ICyan='\033[0;106m'    # Cyan
BG_IWhite='\033[0;107m'   # White

#--------------------------------------------------------------------------------------------

pingpong() {
        clear
        read -p "Gebe eine IP Addresse oder DNS an: " address
        read -p "Gebe eine Anzahl an Pakete ein: " packets
        echo ""
        ping -c $packets $address | grep 'packets transmitted' # sends 10 packets

        # Ping the specified host and store the result
        result=$(ping -c $packets $address)

        # Check if the ping was successful
        if [ $? -ne 0 ]; then
        # If the ping was not successful, gather information about the network
        # connection and create a report
        report="$report $(date)\n\n"
        report="Ping to host $host failed.\n\n"
        report="$report $(ip addr show)"
        report="$report $(route -n)\n\n"

        # Prompt the user for the email address to send the report to
        read -p "Enter the email address to send the report to: " email

        # Send the report to the specified email address
        echo -e $report | mail -s "Ping Failure Report" $email
        else
        echo "Ping to host $host was successful."
        fi
}


ping_troubleshooting() {
        while true;
        do
                clear
                echo -e "${BIRed}┌══════════════════════════┐"
                echo -e "█   Ping Troubleshooting   █"
                echo -e "└══════════════════════════┘${Color_Off}"
                echo ""
                echo -e "${BIRed} [1] Ping an IP Address or DNS "
                echo -e " [2] - "
                echo -e " [3] - "
                echo -e " [4] Skript beenden ${Color_Off}"
                echo ""
                read -p "Wähle eine Option aus: " pingopt

                case $pingopt in

                        1)
                                pingpong
                                ;;
                        2)
                                echo "In Bearbeitung..."
                                ;;
                        3)
                                echo "In Bearbeitung..."
                                ;;
                        4)      
                                clear
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
                                sleep 0.5
                                echo "Skript wird beendet... Aufwiedersehen \( ^_^)／"
                                sleep 1
                                exit # Skript beenden
                                ;;
                        *)
                                echo "Dieser Menüpunkt existiert nicht."
                                sleep 1
                                ;;

                esac                
        done
}
#--------------------------------------------------------------------------------------------
benutzer_und_gruppenverw() {
        echo "Hello"
}
#--------------------------------------------------------------------------------------------
password_generator() {
        echo "Hello"
}
#--------------------------------------------------------------------------------------------
file_manager(){
        echo "Hello"
}
#--------------------------------------------------------------------------------------------
# Auswahlmenü
#--------------------------------------------------------------------------------------------
main() {
        while true;
        do
                # fetch ens33 IP-Addr
                ipaddr=$(ip -4 addr show ens33 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
                # get hostname
                hostn=$(whoami)
                # get mac address of ens33
                macaddr=$(ip link show ens33 | awk '/link\/ether/ {print $2}')
                # get gateway address of ens33
                gateway=$(ip route show default | awk '/ens33/ {print $3}')
                #----------------------------------------------------------------------------
                clear 
                echo -e ""
echo -e "${HIRed}     █████╗ ██╗   ██╗████████╗ ██████╗     "
echo -e "    ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗   "
echo -e "    ███████║██║   ██║   ██║   ██║   ██║   "
echo -e "    ██╔══██║██║   ██║   ██║   ██║   ██║   "
echo -e "    ██║  ██║╚██████╔╝   ██║   ╚██████╔╝   "
echo -e "The ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  Script ${Color_Off}"
                echo ""
                echo "[+]═════[ Author : Karma Khamritshang ]═════[+]"
                echo ""
                echo -e "┌══════════════════════════════════┐"
                echo -e "█    Your Network Configuration    █" 
                echo -e "└══════════════════════════════════┘" 
                echo "┌══════════════════════════════════┐"
                echo "█ Hostname     | $hostn             █"
                echo "█ Interface    | ens33             █"
                echo "█ IP Address   | $ipaddr    █"
                echo "█ Mac Address  | $macaddr █"
                echo "█ Gateway      | $gateway      █"
                echo "└══════════════════════════════════┘"
                echo ""
                echo -e "${BIRed} [1] Ping Troubleshooting "
                echo -e " [2] Benutzer- und Gruppenverwaltung "
                echo -e " [3] Password Manager "
                echo -e " [4] File Manager "
                echo -e " [5] Skript beenden ${Color_Off}"
                echo ""
                read -p "Wähle eine Option aus: " menu

                case $menu in

                        1)
                                ping_troubleshooting
                                ;;
                        2)
                                benutzer_und_gruppenverw
                                ;;
                        3)      
                                password_generator
                                ;;
                        4)      
                                file_manager
                                ;;
                        5)      
                                clear
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
                                sleep 0.5
                                echo "Skript wird beendet... Aufwiedersehen \( ^_^)／"
                                sleep 1
                                exit # Skript beenden
                                ;;
                        *)
                                echo "Dieser Menüpunkt existiert nicht."
                                sleep 1
                                ;;
                esac
        done
}
main # Menü wird als erstes abgerufen
