Scrape v1
by Rob Dixon @304geek
Senior Security Consultant - AccuvantLABS

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
 -i      Import Mode (edit custom.list)
 -m      Malware Mode (https://secure.mayhemiclabs.com/malhosts/malhosts.txt)
 -u      Common AV Mode
 -p      Free Porn Mode
 -t      Target DNS Server

