Snoopy-DNS
==========

Searches for interesting cached DNS entries.

usage: ./snoopy.sh options

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


												
    ,-~~-.___.										
   / |  '     \										
  (  )        0                     Snoopy-DNS v1					
   \_/-, ,----'         __           							
      ====             / /              							
     /  \-'~;         / /                						
    /  __/~|  _______/ /    								
  =(  _____| (_________|									
                              								
                  A proof of concept DNS reconnaissance tool using Dig 
		      to report on suspicious or revealing cached DNS entries.				
            Written by Rob Dixon - Senior Security Consultant - AccuvantLABS
