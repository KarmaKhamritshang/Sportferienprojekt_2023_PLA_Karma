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
        read -p "Enter a valid IP Address or DNS: " address
        read -p "Enter amount of packets: " packets
        echo ""
        ping -c $packets $address 
        # Ping the specified host and store the result
        result=$(ping -c $packets $address)
        # Check if the ping was successful
        if [ $? -ne 0 ]; then
                echo -e "${BIRed}----------------------------"
                echo -e " Ping was not successful"
                echo -e "----------------------------"
                echo -e " [1] Send yourself a report"
                echo -e " [2] Ping again"
                echo -e " [3] Return to main menu"
                echo -e " [4] Exit"
                echo -e "----------------------------${Color_Off}"
                read -p "Choose an option: " failping
                while true; 
                do
                        if [ $failping -eq 1 ]; then
                                # If the ping was not successful, gather information about the network
                                # connection and create a report
                                report="Ping to $address failed. \n\n Here are some solutions: \n\n 1) Check the connectivity: Ensure that the target device is turned on and connected to the network. \n\n 2) Verify the IP address: Make sure that you have entered the correct IP address or hostname of the target device. \n\n 3) Check the firewall: If a firewall is enabled on the target device, it might be blocking the incoming ping request. Disable the firewall temporarily to see if it resolves the issue. \n\n 4) Disable antivirus software: Antivirus software can sometimes interfere with network connectivity. Try disabling it temporarily to see if it resolves the issue. \n\n 5) Restart the network devices: Restart the target device and the device that you are pinging from to ensure that they are functioning properly. \n\n 6) Flush the DNS cache: Clearing the DNS cache can sometimes resolve issues with network connectivity. \n\n 7) Update network drivers: Make sure that you have the latest network drivers installed on your device to ensure optimal network performance. \n\n 8) Check the network cable: If you are using a wired connection, check the network cable for any signs of damage or wear. \n\n 9) Try a different network: If you are using a wireless connection, try moving closer to the router or switch to see if the signal strength improves. If you are using a wired connection, try a different cable or port on the switch. \n\n 10) Check the network settings: Ensure that the network settings on your device are configured correctly, including the IP address, subnet mask, and default gateway.\n\n 11) Contact the network administrator: If you are still unable to ping the target device, reach out to your network administrator for further assistance"                                
                                # Prompt the user for the email address to send the report to
                                read -p "Enter your email address to send the report to: " email
                                # Send the report to the specified email address
                                echo -e $report | mail -s "Ping Failure Report" $email
                                echo "Mail has been sent, check your Junk Folder!"
                                sleep 2.5
                                break
                        elif [ $failping -eq 2 ]; then
                                pingpong
                        elif [ $failping -eq 3 ]; then
                                main
                        elif [ $failping -eq 4 ]; then
                                exit
                        fi
                done
        else    
                echo "Ping to $address was successful."
                read -p "Wanna ping again or return back to the main menu? [ping/menu]: " pingagain
                if [ $pingagain -eq "ping" ]; then
                        pingpong
                else
                        main
                fi
        fi
}

ping_troubleshooting() {
        while true;
        do
                clear
                echo -e "${BIRed}┌══════════════════════════┐"
                echo -e "█   Ping Troubleshooting   █"
                echo -e "└══════════════════════════┘"
                echo ""
                echo -e " [1] Ping an IP Address or DNS "
                echo -e " [2] Return to main menu "
                echo -e " [3] Exit ${Color_Off}"
                echo ""
                read -p "Choose an option: " pingopt

                case $pingopt in

                        1)
                                pingpong
                                ;;
                        2)
                                main
                                ;;
                        3)      
                                clear
                                echo "."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "..."
                                sleep 0.5
                                echo "Exiting script... Goodbye! \( ^_^)／"
                                sleep 1
                                exit # Skript beenden
                                ;;
                        *)
                                echo "This option doesn't exist, try again..."
                                sleep 1.5
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
                echo -e " [2] DNS Flush"
                echo -e " [3] User and Group Management "
                echo -e " [4] Password Manager "
                echo -e " [5] File Manager "
                echo -e " [6] Exit ${Color_Off}"
                echo ""
                read -p "Choose an option: " menu

                case $menu in

                        1)
                                ping_troubleshooting
                                ;;
                        2)      
                                sudo resolvectl flush-caches
                                echo "Flushing DNS Cache..."
                                sleep 2
                                ;;
                        3)
                                clear
                                benutzer_und_gruppenverw
                                ;;
                        4)      
                                clear
                                password_generator
                                ;;
                        5)      
                                clear
                                file_manager
                                ;;
                        6)      
                                clear
                                echo "."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "..."
                                sleep 0.5
                                echo "Exiting script... Goodbye! \( ^_^)／"
                                sleep 1
                                exit # Skript beenden
                                ;;
                        *)
                                echo "This option doesn't exist, try again..."
                                sleep 1
                                ;;
                esac
        done
}
main # Menü wird als erstes abgerufen
