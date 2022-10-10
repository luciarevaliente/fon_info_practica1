#!/bin/bash

# PAS 1
var1=$(wc -l < titles.cvs)
grep ^t"*[ms]" titles.cvs > pas1
var2=$(wc -l < pas1)
var3=$(( $var1-$var2 ))
# S'han esborrat 171 l�nes



# PAS 2
# Busca a la segona columna els car�cters [#'"��] i la resta, els guarda en pas2
grep -v "^[[:alnum:]]*,[#\�\�\'\"]" pas1 > pas2
var4=$(wc -l < pas2)
var5=$(( $var3-$var4))
# S'han esborrat 12 l�nies



# PAS 3
# Busca les l�nies que comencen per ts (show) i les guarda a Shows.csv
# Contem quantes l�nies hi ha a l'arxiu
grep  "^ts" pas2 > Shows.csv
var6=$(wc -l < Shows.csv)
# Busca les l�ines que comencen per tm (movie) i les guarda a Movies.csv
grep "^tm" pas2 > Movies.csv
var7=$(wc -l < Movies.csv)

var8=$(( $var6+$var7 ))
var8==var5
# 1 (True)


# PAS 4