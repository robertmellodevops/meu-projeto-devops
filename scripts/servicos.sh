#!/bin/bash

for SERVICO in ssh cron systemd-resolved; do
    echo "Verificando $SERVICO..."
    systemctl is-active "$SERVICO"
done
