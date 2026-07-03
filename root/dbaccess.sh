#!/bin/bash

# Inicia serviço do dbAccess.
export LC_ALL=C
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.

sed 's/{{PROTHEUS_DB}}/'"${PROTHEUS_DB:-"protheus"}"'/g'             -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTHEUS_USER}}/'"${PROTHEUS_USER:-"protheus"}"'/g'         -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTHEUS_PASSWORD}}/'"${PROTHEUS_PASSWORD:-"protheus"}"'/g' -i /dbaccess/multi/dbaccess.ini

cd /dbaccess/multi/
# exec: dbaccess64 assume o PID 1 e recebe SIGTERM do "docker stop" (shutdown gracioso).
exec ./dbaccess64
