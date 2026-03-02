#!/bin/bash

# Inicia serviço do dbAccess.
export LC_ALL=C
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.

sed 's/{{PROTEUS_DB}}/'"${PROTEUS_DB:-"protheus"}"'/g'             -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTEUS_USER}}/'"${PROTEUS_USER:-"protheus"}"'/g'         -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTEUS_PASSWORD}}/'"${PROTEUS_PASSWORD:-"protheus"}"'/g' -i /dbaccess/multi/dbaccess.ini

cd /dbaccess/multi/
./dbaccess64
