#!/bin/bash

####################################################################
################### FREE OCSAF FUNCTION - PWNED ####################
####################################################################

#########################################################################################################################
#  FROM THE FREECYBERSECURITY.ORG TESTING-PROJECT (GNU-GPLv3) - https://freecybersecurity.org                           #
#  This script is used to perform an automated security audit and point out weaknesses.                                 #
#  To achieve this, security intelligence (OSINT) and security scanning techniques are used and                         #
#  combined with collective intelligence.                                                                               #
#                                                                                                                       #
#  Use only with legal authorization and at your own risk! ANY LIABILITY WILL BE REJECTED!                              #
#                                                                                                                       #
#  Thanks to Navan Chauhan - https://github.com/navanchauhan/Pwned                                                      #
#  Script programming by Mathias Gut, Netchange Informatik GmbH under GNU-GPLv3                                         #
#  Special thanks to the community and also for your personal project support.                                          #
#########################################################################################################################

#######################
### TOOL USAGE TEXT ###
#######################

usage() {
	echo "From the Free OCSAF project"
	echo "Free OCSAF PWNED 0.1 - GPLv3 (https://freecybersecurity.org)"
	echo "Use only with legal authorization and at your own risk!"
       	echo "ANY LIABILITY WILL BE REJECTED!"
       	echo ""	
	echo "USAGE:" 
	echo "  ./freepwnedcheck.sh -m <email address>"
       	echo "  ./freepwnedcheck.sh -l </path/list.txt>"	
       	echo ""	
	echo "EXAMPLE:"
       	echo "  ./freepwnedcheck.sh -m info@freecybersecurity.org"
       	echo ""	
	echo "OPTIONS:"
	echo "  -h, help - this beautiful text"
	echo "  -m <email address>"
	echo "  -l </path/list> - input list with email addresses"
	echo "  -c, no color scheme set"
       	echo ""
	echo "NOTES:"
	echo "#See also the MAN PAGE - https://freecybersecurity.org"
}

###############################
### GETOPTS - TOOL OPTIONS  ###
###############################

while getopts "m:l:hc" opt; do
	case ${opt} in
		h) usage; exit 1;;
		m) mail="$OPTARG"; opt_arg1=1;;
		l) list="$OPTARG"; opt_arg2=1;;
		c) nocolor=1;;
		\?) echo "**Unknown option**" >&2; echo ""; usage; exit 1;;
        	:) echo "**Missing option argument**" >&2; echo ""; usage; exit 1;;
		*) usage; exit 1;;
  	esac
  	done
	shift $(( OPTIND - 1 ))

#Check if opt_arg1 or opt_arg2 is set
if [ "$opt_arg1" == "" ] && [ "$opt_arg2" == "" ]; then
	echo "**No argument set**"
	echo ""
	usage
	exit 1
fi


################### PWNED-CHECK ####################
#Thanks to Navan Chauhan - https://github.com/navanchauhan/Pwned
pwned_check() {
	
	local mail=$1
	local i
	local breach
	local pasteacc
	local mail_pwned

	
	echo "Checking if $mail have been Pwned:"
		
	curl -s -o breach.json "https://haveibeenpwned.com/api/v2/breachedaccount/$mail"
	curl -s -o pasteacc.json "https://haveibeenpwned.com/api/v2/pasteaccount/$mail"

	jq ".[]" breach.json > semibreach.json 
	jq .Title semibreach.json > breach.txt
	jq ".[]" pasteacc.json > semipaste.json 
	jq .Title semipaste.json > pasteacc.txt
	
	if [ "$nocolor" == "" ]; then
		if [[ -s breach.txt ]]; then	
			echo -e "\033[31mPWNED! at:\033[0m"
			breach="$(sed 's/\"//g' breach.txt)"
			mail_pwned=($(echo $mail))
			echo $breach
		fi
		
		if [[ -s pasteacc.txt ]]; then	
			echo -e "\033[31mPaste in!!:\033[0m"
			pasteacc="$(sed 's/\"//g' pasteacc.txt)"
			mail_pwned=($(echo $mail))
			echo $pasteacc
		fi

		if ! [ -s breach.txt ] && ! [ -s pasteacc.txt ]; then	
			echo -e "\033[32mOK\033[0m"
		fi

	elif [ "$nocolor" == "1" ]; then
		if [[ -s breach.txt ]]; then	
			echo "PWNED! at:"
			breach="$(sed 's/\"//g' breach.txt)"
			mail_pwned=($(echo $mail))
			echo $breach
		fi
		
		if [[ -s pasteacc.txt ]]; then	
			echo "Paste in!!:"
			pasteacc="$(sed 's/\"//g' pasteacc.txt)"
			mail_pwned=($(echo $mail))
			echo $pasteacc
		fi

		if ! [ -s breach.txt ] && ! [ -s pasteacc.txt ]; then	
			echo "OK"
		fi
	fi

	rm breach.json
	rm semibreach.json
	rm breach.txt
	rm pasteacc.json
	rm semipaste.json
	rm pasteacc.txt
		
	echo "----------------------"
	sleep 1.2
	echo ""
}


####### MAIN PROGRAM #######

echo ""
echo "############################"
echo "####  MAILPWNED-CHECK  ####"
echo "############################"
echo ""

if [ "$opt_arg1" == "1" ]; then      #Query single mail address
	pwned_check $mail 
	unset mail
	echo ""
elif [ "$opt_arg2" == "1" ]; then    #Query mails from list
	while read line
	do
		pwned_check $line
		unset line
	done <$list
	echo ""
fi


#if [ "$opt_arg2" == "1" ]; then
#	echo ""
#	echo "############################"
#	echo "####  MAILPWNED-CHECK  ####"
#	echo "############################"
#	echo ""
#	while read line
#	do
#		pwned_check $line
#		unset line
#	done <$list
#fi

################### END ###################