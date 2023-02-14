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
                while true;
                do
                        clear
                        echo -e "${BIRed}----------------------------"
                        echo -e " Ping was not successful"
                        echo -e "----------------------------"
                        echo -e " [1] Send yourself a report"
                        echo -e " [2] Ping again"
                        echo -e " [3] Return to main menu"
                        echo -e " [4] Exit"
                        echo -e "----------------------------${Color_Off}"
                        read -p "Choose an option: " failping
                        if [ $failping -eq 1 ]; then
                                # If the ping was not successful, gather information about the network
                                # connection and create a report
                                report="Ping to $address failed. \n\n Here are some solutions: \n\n 1) Check the connectivity: Ensure that the target device is turned on and connected to the network. \n\n 2) Verify the IP address:  Make sure that you have entered the correct IP address or hostname of the target device. \n\n 3) Check the firewall: If a firewall is enabled on the target device, it might be blocking the incoming    ping request. Disable the firewall temporarily to see if it resolves the issue. \n\n 4) Disable antivirus software: Antivirus software can sometimes interfere with network connectivity. Try      disabling it temporarily to see if it resolves the issue. \n\n 5) Restart the network devices: Restart the target device and the device that you are pinging from to ensure that they are functioning        properly. \n\n 6) Flush the DNS cache: Clearing the DNS cache can sometimes resolve issues with network connectivity. \n\n 7) Update network drivers: Make sure that you have the latest network       drivers installed on your device to ensure optimal network performance. \n\n 8) Check the network cable: If you are using a wired connection, check the network cable for any signs of damage or wear.        \n\n 9) Try a different network: If you are using a wireless connection, try moving closer to the router or switch to see if the signal strength improves. If you are using a wired connection, try a  different cable or port on the switch. \n\n 10) Check the network settings: Ensure that the network settings on your device are configured correctly, including the IP address, subnet mask, and         default gateway.\n\n 11) Contact the network administrator: If you are still unable to ping the target device, reach out to your network administrator for further      assistance"                                
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
                        else
                                echo "This option doesn't exist, try again..."
                                sleep 1.5
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
                echo "┌══════════════════════════┐"
                echo "█   Ping Troubleshooting   █"
                echo "└══════════════════════════┘"
                echo ""
                echo -e "${BIRed} [1] Ping an IP Address or DNS "
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
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
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

# 1) Create a new user

create_user() {
        # get power
        power=$(sudo)
        # Ask for Name
        while true; 
        do
                clear
                read -p "Enter username for the new user: " name_user
                if [ -z "$name_user" ]; then
                        echo "No input detected. Try again."
                        sleep 1.5
                else
                        break
                fi
        done
        # Ask for Full Name
        while true;
        do
                clear
                read -p "Enter the full name of the new user: " fullname_user
                if [ -z "$fullname_user" ]; then
                        echo "No input detected. Try again!"
                        sleep 1.5
                else
                        # Ask user if they want to add new user to an existing group
                        while true;
                        do      
                        clear
                        read -p "Do you want to add the new user into a an existing group? (y/n): " adduser_group
                        if [ $adduser_group = "n" ]; then
                                while true;
                                do
                                        clear
                                        read -p "Do you want a home directory for your new user? (y/n): " homedir
                                        if [ -z "$homedir" ]; then
                                                echo "No input detected. Try again!"
                                                sleep 1.5
                                        elif [ $homedir = "y" ]; then 
                                                while true;
                                                do
                                                        clear
                                                        echo "As a general guideline, passwords should consist of 6 to 8 characters"
                                                        echo "including one or more characters from each of the following sets:"
                                                        echo ""
                                                        echo "- lower/upper case alphabetics"
                                                        echo "- digits 0 thru 9"
                                                        echo "- punctuation marks"
                                                        echo ""
                                                        while true;
                                                        do
                                                                read -s -p "Enter a password for the new user: " userpasswd
                                                                if [ -z "$userpasswd" ]; then
                                                                        echo "No input detected. Try again!"
                                                                else
                                                                        # User with name, with fullname, no group, with homedir
                                                                        echo ""
                                                                        sudo useradd -m $name_user -c "$fullname_user" -s /usr/bin/bash -p $userpasswd
                                                                        echo -e "The user ${HIGreen}$name_user${Color_Off} has been created"
                                                                        sleep 3
                                                                        echo "Returning..."
                                                                        sleep 1
                                                                        benutzer_und_gruppenverw        
                                                                fi
                                                        done
                                                done
                                        elif [ $homedir = "n" ]; then
                                                clear
                                                echo "As a general guideline, passwords should consist of 6 to 8 characters"
                                                echo "including one or more characters from each of the following sets:"
                                                echo ""
                                                echo "- lower/upper case alphabetics"
                                                echo "- digits 0 thru 9"
                                                echo "- punctuation marks"
                                                echo ""
                                                while true;
                                                do
                                                        read -s -p "Enter a password for the new user: " userpasswd
                                                        if [ -z "$userpasswd" ]; then
                                                                echo "No input detected. Try again!"
                                                        else
                                                                # User with name, with fullname, no group, no homedir
                                                                echo ""
                                                                sudo useradd $name_user -c "$fullname_user" -s /usr/bin/bash -p $userpasswd
                                                                echo -e "The user ${HIGreen}$name_user${Color_Off} has been created"
                                                                sleep 3
                                                                echo "Returning..."
                                                                sleep 1
                                                                benutzer_und_gruppenverw        
                                                        fi
                                                done
                                        fi
                                done
                        elif [ $adduser_group = "y" ]; then
                                while true;
                                do
                                        clear
                                        read -p "Enter existing group name: " group_name
                                        if [ -z "$group_name" ]; then
                                                echo "No input detected. Try again!"
                                                sleep 1.5
                                        else
                                                while true;
                                                do
                                                        clear
                                                        read -p "Do you want a home directory for your new user? (y/n): " homedir
                                                        if [ -z "$homedir" ]; then
                                                                echo "No input detected. Try again!"
                                                                sleep 1.5
                                                        elif [ $homedir = "y" ]; then
                                                                while true;
                                                                do
                                                                        read -s -p "Enter a password for the new user: " userpasswd
                                                                        if [ -z "$userpasswd" ]; then
                                                                                echo "No input detected. Try again!"
                                                                        else
                                                                                # User with name, with fullname, with group, with homedir
                                                                                echo ""
                                                                                sudo useradd -m $name_user -c "$fullname_user" -G $group_name -s /usr/bin/bash -p $userpasswd
                                                                                echo -e "The user ${HIGreen}$name_user${Color_Off} has been created"
                                                                                sleep 3
                                                                                echo "Returning..."
                                                                                sleep 1
                                                                                benutzer_und_gruppenverw        
                                                                        fi
                                                                done
                                                        elif [ $homedir = "n" ]; then
                                                                while true;
                                                                do
                                                                        read -s -p "Enter a password for the new user: " userpasswd
                                                                        if [ -z "$userpasswd" ]; then
                                                                                echo "No input detected. Try again!"
                                                                        else
                                                                                # User with name, with fullname, with group, no homedir
                                                                                echo ""
                                                                                sudo useradd $name_user -c "$fullname_user" -G $group_name -s /usr/bin/bash -p $userpasswd
                                                                                echo -e "The user ${HIGreen}$name_user${Color_Off} has been created"
                                                                                sleep 3
                                                                                echo "Returning..."
                                                                                sleep 1
                                                                                benutzer_und_gruppenverw        
                                                                        fi
                                                                done
                                                        fi
                                                done
                                        fi
                                done
                        else
                                echo "Incorrect answer. Try again!"
                                sleep 1
                        fi
                        done                
                fi
        done
}

# 3) Delete a user

del_user() {
        while true;
        do
                clear
                read -p "Enter the user you want to delete: " delete_user
                if [ -z "$delete_user" ]; then
                        echo "No input detected. Try again!"
                else
                        echo "Deleting User..."
                        sleep 1
                        sudo userdel $delete_user
                        echo "DONE!"
                        sleep 3
                        echo "Returning..."
                        sleep 1.5
                        break
                fi
        done
}
 
# 4) Create a new group

create_group() {
        echo "Hello"
}

# 5) Delete a group

del_group() {
        echo "Hello"
}

# 6) List groups of a specific user

usergroup_listing() {
        while true;
        do
                clear
                read -p "Enter a user to list the groups that they're inside of: " usrgrlist
                if [ -z "$usrgrlist" ]; then
                        echo "No input detected. Try again!"
                        sleep 1.5
                else
                        sleep 1
                        echo "Listing groups..."
                        sleep 0.5
                        groups $usrgrlist
                        read -p "Do you wanna list again or return? (again/return) :" answusrgrlist
                        if [ -z "$answusrgrlist" ]; then
                                echo "No input detected. Try again!"
                        elif [ $answusrgrlist = "again" ]; then
                                usergroup_listing
                        elif [ $answusrgrlist = "return" ]; then
                                echo "Returning..."
                                sleep 1
                                benutzer_und_gruppenverw
                        fi
                fi
        done
}

# 7) Listing existing groups

groups_listing() {
        while true;
        do
                clear
                cut -d: -f1 /etc/group
                echo "---------------------------------------------------------------------------"
                read -p "Do you wanna list the groups again or return? (again/return): " gl_answer
                if [ $gl_answer = "again" ]; then
                        groups_listing
                elif [ $gl_answer = "return" ]; then
                        echo "Returning..."
                        sleep 1
                        benutzer_und_gruppenverw
                else
                        echo "Incorrect answer. Try again!"
                        sleep 1.5
                fi
        done
}


benutzer_und_gruppenverw() {
        while true;
        do
                clear
                echo "┌══════════════════════════════┐"
                echo "█   User and Group Management  █"
                echo "└══════════════════════════════┘"
                echo ""
                echo -e "${BIRed} [1] Create new user "
                echo -e " [2] List currently logged in users "
                echo -e " [3] Delete a user "
                echo -e " [4] Create a new group "
                echo -e " [5] Delete a group "
                echo -e " [6] List groups of a specific user"
                echo -e " [7] List existing groups of current process"
                echo -e " [8] Return to main menu "
                echo -e " [9] Exit ${Color_Off}"
                echo ""
                read -p "Choose an option: " pingopt
                case $pingopt in

                        1)
                                create_user
                                ;;
                        2)
                                clear
                                echo "Those are the currently logged in users:"
                                sleep 1
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
                                sleep 0.5
                                users
                                sleep 3.5
                                echo "Returning..."
                                sleep 1
                                ;;
                        3)
                                del_user
                                ;;
                        4)
                                create_group
                                ;;
                        5)
                                del_group
                                ;;
                        6)
                                usergroup_listing
                                ;;
                        7)
                                groups_listing
                                ;;
                        8)
                                main
                                ;;
                        9)
                                clear
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
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
                hostn=$(hostname)
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
                echo -e "┌══════════════════════════════════════┐"
                echo -e "█    Your Network Configuration        █" 
                echo -e "└══════════════════════════════════════┘" 
                echo "┌══════════════════════════════════════┐"
                echo "█ Hostname     | $hostn █"
                echo "█ Interface    | ens33                 █"
                echo "█ IP Address   | $ipaddr        █"
                echo "█ Mac Address  | $macaddr     █"
                echo "█ Gateway      | $gateway          █"
                echo "└══════════════════════════════════════┘"
                echo ""
                echo -e "${BIRed} [1] Ping Troubleshooting "
                echo -e " [2] DNS Flush"
                echo -e " [3] User and Group Management "
                echo -e " [4] Password Manager "
                echo -e " [5] File Manager "
                echo -e " [6] Exit "
                echo -e " [7] Restart${Color_Off} "
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
                                echo "Done!"
                                sleep 1
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
                                echo "..."
                                sleep 0.5
                                echo ".."
                                sleep 0.5
                                echo "."
                                sleep 0.5
                                echo "Exiting script... Goodbye! \( ^_^)／"
                                sleep 1
                                exit # Skript beenden
                                ;;
                        7)      
                                sudo reboot
                                ;;

                        99) # Schneller Shutdown
                                clear
                                echo -e "${BIRed}Self destruction in.."
                                sleep 1
                                echo -e "5.."
                                sleep 1
                                echo -e "4.."
                                sleep 1
                                echo -e "3.."
                                sleep 1
                                echo -e "2.."
                                sleep 1
                                echo -e "1..${Color_Off}"
                                sleep 1
                                sudo shutdown now # Funktioniert ohne Eingabe des Passwords, wenn der Admin kein Passwort definiert hat.
                                ;;
                        *)
                                echo "This option doesn't exist, try again..."
                                sleep 1
                                ;;
                esac
        done
}
main # Menü wird als erstes abgerufen
