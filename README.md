Scrape v1
by Rob Dixon @304geek
Senior Security Consultant - AccuvantLABS
&
Vito Margetic

Licensed under GPL v2 (see COPYING)

Check DNS servers for interesting cached entries

Examples:

./scrape.sh -t 8.8.8.8 -a

./scrape.sh -t 8.8.8.8 -o

./scrape.sh -t 8.8.8.8 -u

./scrape.sh -t 8.8.8.8 -i custom.list

OPTIONS:

 -h      Show this message
 
 -a      All Mode 
 
 -i      Import Mode (custom.list)
 
 -u      Common AV Mode
 
 -o      Obscene Mode
 
 -t      Target DNS Server

=====================================================================

Timing-Scrape.sh

by Rob Dixon @304geek
Senior Security Consultant - AccuvantLABS

Timing-Scrape.sh <server-ip> <mode>

Example:

Timing-Scrape.sh 8.8.8.8 custom

Modes:

custom

porn

updates

all
