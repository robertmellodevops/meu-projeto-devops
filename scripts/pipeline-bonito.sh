#!/bin/bash
set -e

CIANO=$'\033[36m'; VERDE=$'\033[32m'; VERMELHO=$'\033[31m'
LARANJA=$'\033[33m'; CINZA=$'\033[90m'; NEGRITO=$'\033[1m'; RESET=$'\033[0m'
PAUSA="${PAUSA:-1}"

stage() {
    num="$1"; icone="$2"; nome="$3"; script="$4"
    echo ""
    echo "${CIANO}┌─ ${icone}  STAGE ${num}/3 · ${nome}${RESET}"
    ini=$(date +%s)
    if saida=$(./"$script" 2>&1); then ok=1; else ok=0; fi
    while IFS= read -r linha; do
        printf '%s│%s %s\n' "$CIANO" "$RESET" "$linha"
    done <<< "$saida"
    sleep "$PAUSA"
    dur=$(( $(date +%s) - ini ))
    echo "${LARANJA}├▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬${RESET}"
    if [ "$ok" -eq 1 ]; then
        echo "${VERDE}└─ ✔ ${nome} passou (${dur}s)${RESET}"
    else
        echo "${VERMELHO}└─ ✘ ${nome} FALHOU (${dur}s) - esteira parada${RESET}"
        exit 1
    fi
}

inicio_total=$(date +%s)
echo "${CIANO}╔════════════════════════════════════════════╗"
echo "║   ESTEIRA DEVOPS - BOOTCAMP 2026           ║"
echo "║   build → test → deploy                    ║"
echo "╚════════════════════════════════════════════╝${RESET}"
echo "${CINZA}iniciada por $(whoami)@$(hostname) as $(date '+%H:%M:%S')${RESET}"

stage 1 "🔨" BUILD build.sh
stage 2 "🔎" TEST test.sh
stage 3 "🚀" DEPLOY deploy.sh

echo ""
echo "${VERDE}╔════════════════════════════════════════════╗"
echo "║  ✔  PIPELINE VERDE - aplicacao em producao ║"
echo "╚════════════════════════════════════════════╝${RESET}"
echo "${CINZA}tempo total: $(( $(date +%s) - inicio_total ))s · em producao agora:${RESET}"
echo "${NEGRITO}$(cat ~/producao/index.html)${RESET}"
