#!/bin/bash
function usage(){
cat << EOF

usage: $0 options

Check DNS servers for interesting cached entries

Examples: 

./scrape.sh -t 8.8.8.8 -a
./scrape.sh -t 8.8.8.8 -p
./scrape.sh -t 8.8.8.8 -u
./scrape.sh -t 8.8.8.8 -m
./scrape.sh -t 8.8.8.8 -c
./scrape.sh -t 8.8.8.8 -i custom_sites.list

OPTIONS:
   -h      Show this message
   -a      All Mode (includes, yup, ALL lists)
   -i      Import Mode (-i sites.list)
   -m      Malware Mode (https://secure.mayhemiclabs.com/malhosts/malhosts.txt)
   -u      Common AV Mode
   -p      Free Porn Mode
   -t      Target DNS Server
EOF
}


#################################################################
#								#
# Scrape v1							#
#								#
# By Rob Dixon							#					
# Senior Security Consultant					#
# AccuvantLABS							#
#								#
# Thanks Netinfinity for helping with the option handling!	#
#								#
# Let's go and see what people are doing..			#
#								#
#################################################################

INFILE=
TARGET=
while getopts “iht:mpua” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
 	 t)
	     TARGET=$OPTARG
	     ;;
         m)
	     MODE=malware
	     TITLE="Potential Malware Sites Discovered:"
	     echo "Updating malware list from https://secure.mayhemiclabs.com/malhosts/malhosts.txt"
	     echo""
	     rm malware.list
	     curl -k https://secure.mayhemiclabs.com/malhosts/malhosts.txt | cut -f1 | grep -v "#" | sed '/^$/d' |sort -u >> malware.list
             ;;
         p)
	     MODE=porn
	     TITLE="Known Pornography Sites Discovered:"
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
  echo "Scraped results for : $TARGET     " 
  echo -n "This test was conducted on: "
  date
  echo ""
  rm output/$TARGET.output
  echo $TARGET >> output/$TARGET.output
  date >> output/$TARGET.output
  dig @$TARGET -f $MODE.list +norecurse >> output/$TARGET.output
  echo Results:
  cat output/$TARGET.output | sed '/^$/d'| sed "s/^/[+] $TITLE : /g" | grep -A 1 "ANSWER SECTION" | grep -v "ANSWER SECTION" | sort -u 
  exit 2
fi

if [[ $1 -eq 0 ]] || [[ $2 -eq 0 ]]
  then
    usage
fi



