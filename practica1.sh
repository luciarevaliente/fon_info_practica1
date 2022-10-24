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
echo ""
echo "S'han esborrat $var5 linies"
# S'han esborrat 11 línies


# PAS 3
# SHOWS.CSV
grep  "^ts" pas2 > Shows.csv
var6=$(wc -l < Shows.csv)
# A l'arxiu Shows.csv hi ha 2045 línies

# MOVIES.CSV
grep "^tm" pas2 > Movies.csv
var7=$(wc -l < Movies.csv)
# A l'arxiu Movies.csv hi ha 3749 línies
var8=$(( $var6+$var7 ))
# La suma de les línies dels dos arxius és 5794
echo ""
if [ $var8 == $var4 ]; then
  echo "1"
else
  echo "0"
fi


# PAS 4
# MOVIES.CSV
awk -F',' '{if (($12 != "") && ($13 != "") && ($14 != "") && ($15 != "")){print $0}}' Movies.csv > Movies_net.csv
var9=$(wc -l < Movies_net.csv)
var10=$(( $var7-$var9 ))
echo ""
echo "S'han esborrat $var10 linies de Movies.csv"
# S'han esborrat 549 línies del Movies.csv

# SHOWS.CSV
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

# SHOWS.CSV
max13=$(awk -F',' 'BEGIN {max13=0}; {if($13>max13){max13=$13}}; END{print max13}' Shows.csv)
max14=$(awk -F',' 'BEGIN {max14=0}; {if($14>max14){max14=$14}}; END{print max14}' Shows.csv)
awk -F',' -v max13=$max13 -v max14=$max14 '{fiabilitat13=( $12*($13/max13) ); fiabilitat14=( $15*($14/max14)); print $0 "," fiabilitat13 "," fiabilitat14}' Shows_net.csv > Shows_f.csv

# PAS 6
# IMBD
# a.
echo ""
echo "Pel.licula amb millor puntuacio IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($12>max) {max=$12; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,12
echo ""
# b.
echo "Serie amb millor puntuacio IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($12>max) {max=$12; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,12
echo ""
# c.
echo "Pel.licula amb mes popularitat segons IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($13>max) {max=$13; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,13
echo ""
# d. 
echo "Serie amb mes popularitat segons IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($13>max) {max=$13; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,13
echo ""
# e.
echo "Pel.licula amb millor coeficient de fiabilitat IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($16>max) {max=$16; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,16
echo ""
# f.
echo "Serie amb millor coeficient de fiabilitat IMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($16>max) {max=$16; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,16
echo ""

# TMBD
# a.
echo "Pel.licula amb millor puntuacio TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($15>max) {max=$15; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,15
echo ""
# b.
echo "Serie amb millor puntuacio TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($15>max) {max=$15; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,15
echo ""
# c.
echo "Pel.licula amb mes popularitat segons TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($14>max) {max=$14; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,14
echo ""
# d. 
echo "Serie amb mes popularitat segons TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($14>max) {max=$14; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,14
echo ""
# e.
echo "Pel.licula amb millor coeficient de fiabilitat TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($17>max) {max=$17; registre=$0}}; END{print registre}' Movies_f.csv | cut -d',' -f1,2,9,17
echo ""
# f.
echo "Serie amb millor coeficient de fiabilitat TMDB:"
awk -F',' 'BEGIN {max=0; registre=0}; {if ($17>max) {max=$17; registre=$0}}; END{print registre}' Shows_f.csv | cut -d',' -f1,2,9,17
echo ""

# PAS FINAL
# DOCUMENT ORIGINAL: titles.cvs
# ARXIUS PROCESSATS I NETS: Movies_f.csv, Shows_f.csv
rm pas1
rm pas2
rm Shows.csv
rm Movies.csv
rm Movies_net.csv
rm Shows_net.csv