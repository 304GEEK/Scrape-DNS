#!/bin/bash
#########################################################################################
#											#
#    ,-~~-.___.            								#
#   / |  '     \            								#
#  (  )        0                     Snoopy-DNS v1					#	
#   \_/-, ,----'         __           							#
#      ====             / /              						#
#     /  \-'~;         / /                						#
#    /  __/~|  _______/ /    								#
#  =(  _____| (_________|								#
#                              								#
#                      A proof of concept DNS reconnaissance tool			#
#            Written by Rob Dixon - Senior Security Consultant - AccuvantLABS		#
#											#
#########################################################################################
{
cat << EOF
usage: $0 options

Check DNS servers for interesting cached entries

Examples: 

./snoopy.sh -t 8.8.8.8 -a
./snoopy.sh -t 8.8.8.8 -p
./snoopy.sh -t 8.8.8.8 -u
./snoopy.sh -t 8.8.8.8 -m
./snoopy.sh -t 8.8.8.8 -c
./snoopy.sh -t 8.8.8.8 -i custom_sites.list

OPTIONS:
   -h      Show this message
   -a      All Mode (includes, yup, ALL lists)
   -c	   Top Controversial Mode
   -i      Import Mode (-i sites.list)
   -m      Top Malware Mode
   -u      Common AV Mode
   -p      Top Free Porn Mode
   -t 	   Target DNS Server

EOF
}

INFILE=
TARGET=
while getopts “ihct:mpua” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
	 c)
             TITLE="Controversial Sites Discovered:"
	     echo $TARGET >> output/$TARGET.controversial.output
             date >> output/$TARGET.controversial.output
             dig @$TARGET -f controversial.list +norecurse >> output/$TARGET.controversial.output
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
echo ""
echo "												"
echo "    ,-~~-.___.										"
echo "   / |  '     \										"
echo "  (  )        0                     Snoopy-DNS v1					"
echo "   \_/-, ,----'         __           							"
echo "      ====             / /              							"
echo "     /  \-'~;         / /                						"
echo "    /  __/~|  _______/ /    								"
echo "  =(  _____| (_________|									"
echo "                              								"
echo "                  A proof of concept DNS reconnaissance tool using Dig "
echo "		      to report on suspicious or revealing cached DNS entries.				"
echo "            Written by Rob Dixon - Senior Security Consultant - AccuvantLABS		"
echo "												"
echo "					              						"
echo " 		            Snooped results for DNS server : $TARGET			"
echo "												"
echo ""
echo -n "                This test was conducted on: "
date
echo ""
echo Results:
cat output/$TARGET.*.output | sed '/^$/d'| sed "s/^/[+] $TITLE Success - /g" | grep -A 1 "ANSWER SECTION" | grep -v "ANSWER SECTION" | sort -u 
