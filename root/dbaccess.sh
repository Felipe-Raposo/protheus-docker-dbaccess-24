#!/bin/bash

# Inicia serviço do dbAccess.
export LC_ALL=C
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.

sed 's/{{PROTHEUS_DB}}/'"${PROTHEUS_DB:-"protheus"}"'/g'             -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTHEUS_USER}}/'"${PROTHEUS_USER:-"protheus"}"'/g'         -i /dbaccess/multi/dbaccess.ini
sed 's/{{PROTHEUS_PASSWORD}}/'"${PROTHEUS_PASSWORD:-"protheus"}"'/g' -i /dbaccess/multi/dbaccess.ini

# Publica o dbapi.so para o AppServer baixar antes de subir.
nohup python3 -m http.server 7891 --bind 0.0.0.0 --directory /dbaccess/client >/proc/1/fd/1 2>&1 &
http_pid=$!
ready=0
for _ in $(seq 1 50); do
	if echo > /dev/tcp/127.0.0.1/7891 2>/dev/null; then
		ready=1
		break
	fi
	if ! kill -0 "$http_pid" 2>/dev/null; then
		echo "Falha ao publicar dbapi.so" >&2
		exit 1
	fi
	sleep 0.1
done
if [[ "$ready" -ne 1 ]]; then
	echo "Falha ao publicar dbapi.so" >&2
	exit 1
fi

cd /dbaccess/multi/
# exec: dbaccess64 assume o PID 1 e recebe SIGTERM do "docker stop" (shutdown gracioso).
exec ./dbaccess64
