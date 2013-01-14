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
	     TITLE="Known Malware Sites Discovered:"
	     echo $TARGET >> output/$TARGET.malware.output
             date >> output/$TARGET.malware.output	
	     dig @$TARGET -f malware.list +norecurse >> output/$TARGET.malware.output
             ;;
         p)
	     TITLE="Known Pornography Sites Discovered:"
	     echo $TARGET >> output/$TARGET.porn.output
             date >> output/$TARGET.porn.output
	     dig @$TARGET -f porn.list +norecurse >> output/$TARGET.porn.output
             ;;
	 u)
	     TITLE="Known AV Update Sites Discovered:"
	     echo $TARGET >> output/$TARGET.updates.output
             date >> output/$TARGET.updates.output
	     dig @$TARGET -f updates.list +norecurse >> output/$TARGET.updates.output
             ;;
	 a)  
	     TITLE="Target Sites Discovered:"
	     echo $TARGET >> output/$TARGET.all-sites.output
             date >> output/$TARGET.all-sites.output
	     dig @$TARGET -f all.list +norecurse >> output/$TARGET.all-sites.output 
	     ;;
	 i)  
	     TITLE="Target Sites Discovered:"
	     echo $TARGET >> output/$TARGET.import.output
	     date >> output/$TARGET.$import.output
	     dig @$TARGET -f custom.list +norecurse >> output/$TARGET.import.output
	     ;;
         ?)
             usage
             exit
             ;;
     esac
done
echo "     	     	     _        _        _        _        _        _    
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
echo Results:
cat output/$TARGET.*.output | sed '/^$/d'| sed "s/^/[+] $TITLE Success - /g" | grep -A 1 "ANSWER SECTION" | grep -v "ANSWER SECTION" | sort -u 
