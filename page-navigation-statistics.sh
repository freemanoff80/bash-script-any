#!/bin/bash

set -e

ARREY_SITES=(
http://test-site.ru/deposits/calculator/
http://test-site.ru/cards/general/calculator-v2/
http://test-site.ru/cards/general/calculator-newcards/
http://test-site.ru/credits/credit_cash/calculator-front/
http://test-site.ru/deposits/calculator_investment/
http://test-site.ru/deposits/all/
http://test-site.ru/cards/perevod/
http://test-site.ru/cards/snyatie/
http://test-site.ru/client_com/dist_sales/int_help/
)

ARREY_MONTHS=(
Aug
Sep
Oct
)

declare -A TOTAL_RESULT_MATRIX

COUNT_SUMM=$(( ${#ARREY_MONTHS[@]} * ${#ARREY_SITES[@]} ))
COUNT='1'

for KEY_MONTH in ${!ARREY_MONTHS[@]}; do 
        for KEY_SITE in ${!ARREY_SITES[@]}; do 
                TOTAL_RESULT_MATRIX[$KEY_MONTH,$KEY_SITE]=`gzip -cd bluebook.access.log.*.gz|grep ${ARREY_SITES[$KEY_SITE]} |grep GET|grep 200|grep /${ARREY_MONTHS[$KEY_MONTH]}/2021|wc -l`; 
                printf '%6s\r' "`bc <<<"scale=1; (  100 / ${COUNT_SUMM} ) * ${COUNT}"`%"; 
                COUNT=$(( ${COUNT} + 1 ));
        done; 
done

printf '%6s\n\n' "100.0%"

for KEY_MONTH in ${!ARREY_MONTHS[@]}; do
        printf '%8s' "${ARREY_MONTHS[$KEY_MONTH]}";
done

echo '';

for KEY_SITE in ${!ARREY_SITES[@]}; do
        for KEY_MONTH in ${!ARREY_MONTHS[@]}; do
                printf '%8s' "${TOTAL_RESULT_MATRIX[$KEY_MONTH,$KEY_SITE]}";
        done;
        printf '%5s%8s' "" "${ARREY_SITES[$KEY_SITE]}"
        echo '';
done
