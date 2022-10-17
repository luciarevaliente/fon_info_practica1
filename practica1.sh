#!/bin/bash

# PAS 1
var1=$(wc -l < titles.cvs)
grep ^t"*[ms]" titles.cvs > pas1
var2=$(wc -l < pas1)
var3=$(( $var1-$var2 ))
# S'han esborrat 171 línes
echo "S'han esborrat $var3 linies"



# PAS 2
# Busca a la segona columna els caràcters [#'"¿¡] i la resta, els guarda en pas2
grep -v "^[[:alnum:]]*,[#\'\"\¿\¡]" pas1 > pas2
var4=$(wc -l < pas2)
var5=$(( $var2-$var4 ))
# S'han esborrat 12 línies
echo "S'han esborrat $var5 linies"


# PAS 3
# Busca les línies que comencen per ts (show) i les guarda a Shows.csv
# Contem quantes línies hi ha a l'arxiu
grep  "^ts" pas2 > Shows.csv
var6=$(wc -l < Shows.csv)
# Busca les líines que comencen per tm (movie) i les guarda a Movies.csv
grep "^tm" pas2 > Movies.csv
var7=$(wc -l < Movies.csv)

var8=$(( $var6+$var7 ))

echo $var8
echo $var4

#hay que hacer un if: ESTÁ MAL
if [ $var8 == $var4 ]; then
  echo "1"
else
  echo "0"
fi


# PAS 4
awk -F',' '{if ($12 != ""){print $0}}' Movies.csv > Movies_columna12.csv
awk -F',' '{if ($13 != ""){print $0}}' Movies_columna12.csv > Movies_columna13.csv
awk -F',' '{if ($14 != ""){print $0}}' Movies_columna13.csv > Movies_columna14.csv
awk -F',' '{if ($15 != ""){print $0}}' Movies_columna14.csv > Movies_columna15.csv
var9=$(wc -l < Movies_columna15.csv)
# S'han esborrat 549 línies del Movies.csv
var10=$(( $var7-$var9 ))
echo "S'han esborrat $var10 linies de Movies.csv"

awk -F',' '{if ($12 != ""){print $0}}' Shows.csv > Shows_columna12.csv
awk -F',' '{if ($13 != ""){print $0}}' Shows_columna12.csv > Shows_columna13.csv
awk -F',' '{if ($14 != ""){print $0}}' Shows_columna13.csv > Shows_columna14.csv
awk -F',' '{if ($15 != ""){print $0}}' Shows_columna14.csv > Shows_columna15.csv
var11=$(wc -l < Shows_columna15.csv)
# S'han esborrat 316 línies del Shows.csv
var12=$(( $var6-$var11 ))
echo "S'han esborrat $var12 linies de Shows.csv"


# PAS 5
# vamos a la primera línia i que guarde el valor de la columna 13 en una variable
# vaya a la siguiente linia y compare el valor de la variable con el valor de la columnaa 13
# si el valor de la linia es más grande que el de la variable, que guarde ese nuevo valor en la variable; sino que no haga nad
# HAY QUE HACERLO CON LA COLUMNA 13 Y LA 14
awk -F',' {}

# queremos que añada en la última columna de cada fila lo que pone entre "$13/variable creada antes"
# HAY QUE HACERLO CON EL MOVIES Y EL SHOWS
awk '{print $0 "\t" ", $($13/$(variablecreada1), $($14/$(variablecreada2))"}' Movies_columna15.csv > Movies_columna16.csv