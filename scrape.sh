#!/bin/bash
{
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
   -t 	   Target DNS Server

EOF
}

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
	     TITLE="Known Malware Sites Discovered:"
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
	     TITLE="Known AV Update Sites Discovered:"
             ;;
	 a)  
	     MODE=all
	     TITLE="Target Sites Discovered:"
	     ;;
	 i)  
	     MODE=custom
	     TITLE="Target Sites Discovered:"
	     ;;
         ?)
             usage
             exit
             ;;
     esac
done
echo "     	     	     _        _        _        _        _        _    "
echo "  	   	   _( )__   _( )__   _( )__   _( )__   _( )__   _( )__ "
echo " 		 	 _|     _|_|     _|_|     _|_|     _|_|     _|_|     _|"
echo "			(_ S _ (_(_ C _ (_(_ R _ (_(_ A _ (_(_ P _ (_(_ E _ (_ "
echo "  		  |_( )__| |_( )__| |_( )__| |_( )__| |_( )__| |_( )__|"
echo " "
echo "                              	Scrape-DNS v1							"
echo "                  A proof of concept DNS reconnaissance tool using Dig "
echo "		      to report on suspicious or revealing cached DNS entries.				"
echo "            Written by Rob Dixon - Senior Security Consultant - AccuvantLABS		"
echo "												"
echo "					              						"
echo " 		            Scraped results for DNS server : $TARGET			"
echo "												"
echo ""
echo -n "                This test was conducted on: "
date
echo ""
echo $TARGET >> output/$TARGET.output
date >> output/$TARGET.output
dig @$TARGET -f $MODE.list +norecurse >> output/$TARGET.output
echo Results:
cat output/$TARGET.*.output | sed '/^$/d'| sed "s/^/[+] $TITLE Success - /g" | grep -A 1 "ANSWER SECTION" | grep -v "ANSWER SECTION" | sort -u 
