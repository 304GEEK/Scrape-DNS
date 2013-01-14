Scrape-DNS
==========

Searches for interesting cached DNS entries.

usage: ./scrape.sh options

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
   -c	   Top Controversial Mode
   -i      Import Mode (-i sites.list)
   -m      Top Malware Mode
   -u      Common AV Mode
   -p      Top Free Porn Mode
   -t 	   Target DNS Server


												
    ,-~~-.___.										
   / |  '     \										
  (  )        0                     Scrape-DNS v1					
   \_/-, ,----'         __           							
      ====             / /              							
     /  \-'~;         / /                						
    /  __/~|  _______/ /    								
  =(  _____| (_________|									
                              								
                  A proof of concept DNS reconnaissance tool using Dig 
		      to report on suspicious or revealing cached DNS entries.				
            Written by Rob Dixon - Senior Security Consultant - AccuvantLABS
