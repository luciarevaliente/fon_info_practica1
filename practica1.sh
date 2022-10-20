#!/bin/bash

# PAS 1
var1=$(wc -l < titles.cvs)
grep ^t"*[ms]" titles.cvs > pas1
var2=$(wc -l < pas1)
var3=$(( $var1-$var2 ))
echo "S'han esborrat $var3 linies"
# S'han esborrat 171 línes


# PAS 2
grep -v "^[[:alnum:]]*,[#\'\"\¿\¡]" pas1 > pas2
var4=$(wc -l < pas2)
var5=$(( $var2-$var4 ))
echo "S'han esborrat $var5 linies"
# S'han esborrat 11 línies


# PAS 3
grep  "^ts" pas2 > Shows.csv
var6=$(wc -l < Shows.csv)
# A l'arxiu Shows.csv hi ha 2045 línies
grep "^tm" pas2 > Movies.csv
var7=$(wc -l < Movies.csv)
# A l'arxiu Movies.csv hi ha 3749 línies
var8=$(( $var6+$var7 ))
# La suma de les línies dels dos arxius és 5794
if [ $var8 == $var4 ]; then
  echo "1"
else
  echo "0"
fi


# PAS 4
awk -F',' '{if (($12 != "") && ($13 != "") && ($14 != "") && ($15 != "")){print $0}}' Movies.csv > Movies_net.csv
var9=$(wc -l < Movies_net.csv)
var10=$(( $var7-$var9 ))
echo "S'han esborrat $var10 linies de Movies.csv"
# S'han esborrat 549 línies del Movies.csv

awk -F',' '{if (($12 != "") && ($13 != "") && ($14 != "") && ($15 != "")){print $0}}' Shows.csv > Shows_net.csv
var11=$(wc -l < Shows_net.csv)
var12=$(( $var6-$var11 ))
echo "S'han esborrat $var12 linies de Shows.csv"
# S'han esborrat 316 línies del Shows.csv


# PAS 5
# MOVIES.CSV
max13=$(awk -F',' 'BEGIN {max13=0}; {if($13>max13){max13=$13}}; END{print max13}' Movies.csv)
max14=$(awk -F',' 'BEGIN {max14=0}; {if($14>max14){max14=$14}}; END{print max14}' Movies.csv)
awk -F',' -v max13=$max13 -v max14=$max14 '{fiabilitat13=( $12*($13/max13) ); fiabilitat14=( $15*($14/max14)); print $0 "," fiabilitat13 "," fiabilitat14}' Movies_net.csv > Movies_f.csv
# cut -d',' -f16,17 Movies_f.csv | less

# SHOWS.CSV
max13=$(awk -F',' 'BEGIN {max13=0}; {if($13>max13){max13=$13}}; END{print max13}' Shows.csv)
max14=$(awk -F',' 'BEGIN {max14=0}; {if($14>max14){max14=$14}}; END{print max14}' Shows.csv)
awk -F',' -v max13=$max13 -v max14=$max14 '{fiabilitat13=( $12*($13/max13) ); fiabilitat14=( $15*($14/max14)); print $0 "," fiabilitat13 "," fiabilitat14}' Shows_net.csv > Shows_f.csv
# cut -d',' -f16,17 Shows_f.csv | less

# PAS 6