#!/bin/sh
set -e

# Si ya existe la base de datos → no rebootstrap
if [ -f "/data/portainer.db" ]; then
    exec "$@" --data "/data"
fi

# Arrancar portainer en background
/opt/portainer-bin/portainer --data "/data" &
PID=$!

# Esperar a que la API esté lista
until curl -k https://localhost:9443/api/status >/dev/null 2>&1; do
    sleep 1
done

curl -k -X POST "https://localhost:9443/api/users/admin/init" \
  -H "Content-Type: application/json" \
  -d "{
        \"Username\": \"$PORTAINER_ADMIN\",
        \"Password\": \"$PORTAINER_PASSWORD\"
      }"

kill $PID
wait $PID

exec "$@" --data "/data"
