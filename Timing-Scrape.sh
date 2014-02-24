#########################################################################
#									#
#	Copyright (c) 2013 Rob Dixon 					#
#									#
# This program is free software; you can redistribute it and/or		#
# modify it under the terms of the GNU General Public License as	#
# published by the Free Software Foundation; either version 2 of the	#
# License, or (at your option) any later version.  See the file		#
# COPYING included with this distribution for more information.		#							#
#########################################################################

TARGET=$1
MODE=$2


for DOMAIN in $(cat $MODE.list);
	do 
	echo " ";echo "Now Testing :$DOMAIN";for time in $(seq 1 10);
		do for i in $(dig @$TARGET $DOMAIN | grep "Query time:"| sort -u | cut -d " " -f4);
			do ./bar.sh $i 2
		done

	done
done
