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
