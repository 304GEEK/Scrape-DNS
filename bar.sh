#/bin/bash
#
# borrowed from http://novemberochtend.blogspot.com/2008/12/poor-mans-bar-graph-in-bash.html
#
#  Thanks Ger-Jan
#
for i in `seq $1`
 do
 if [ `expr $i % $2` -eq 0 ]
  then
  echo -n "|"
 fi
done
echo " $1"
