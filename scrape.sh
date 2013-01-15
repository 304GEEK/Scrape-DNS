#!/bin/bash
clear
#################################################################
#								#
# Scrape v1							#
#								#
# By Rob Dixon							#					
# Senior Security Consultant					#
# AccuvantLABS							#
# @304geek							#
#								#
# Thanks @@NodeZero_Linux for helping with the option handling!	#
#								#
# Let's go and see what people are doing..			#
#								#
#################################################################
function usage(){
cat << EOF

usage: $0 options

Check DNS servers for interesting cached entries

Examples: 

./scrape.sh -t 8.8.8.8 -a
./scrape.sh -t 8.8.8.8 -p
./scrape.sh -t 8.8.8.8 -u
./scrape.sh -t 8.8.8.8 -c
./scrape.sh -t 8.8.8.8 -i custom_sites.list

OPTIONS:
   -h      Show this message
   -a      All
   -i      Import Mode
   -u      Common AV Update
   -p      Obscene
   -t      Target DNS Server
EOF
}



INFILE=
TARGET=
while getopts “iht:moua” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
 	 t)
	     TARGET=$OPTARG
	     ;;
      
         o)
	     MODE=porn
	     TITLE="Known Obscene Sites Discovered:"
             ;;
	 u)
	     MODE=updates
	     TITLE="Common AV Update Sites Discovered:"
             ;;
	 a)  
	     MODE=all
	     TITLE="Target Sites Discovered:"
	     ;;
	 i)  
	     MODE=custom
	     TITLE="Target Sites Discovered:"
	     ;;
   \?)
       usage
       exit
       ;;
   * ) 
       usage
       exit 1
       ;;
     esac
done

if [[ $1 == -* ]]
 then
  rm output/$TARGET.output
  clear
  echo "Scraped results for : $TARGET     " 
  echo -n "This test was conducted on: "
  date
  dig @$TARGET -f $MODE.list +norecurse | sed '/^$/d'| sed "s/^/[+] $TITLE : /g" | grep -A 1 "ANSWER SECTION" | grep -v "ANSWER SECTION" | sort -u 
  exit 2
fi

if [[ $1 -eq 0 ]] || [[ $2 -eq 0 ]]
  then
    usage
fi



