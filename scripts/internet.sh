#!/bin/bash

if ping -c 1 matera.com > /dev/null 2>&1; then
    echo "[OK] Internet"
else
    echo "[FALHA] Sem internet"
fi
