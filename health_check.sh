#!/bin/bash
# ==============================================================================
# Script: health_check.sh
# Descrição: Validação automatizada de conectividade para ambiente Staging
# Autor: Amanda Carlos Donella (Analista de Infraestrutura)
# ==============================================================================

echo "=================================================="
echo "   INICIANDO HEALTH CHECK - AMBIENTE DE STAGING   "
echo "=================================================="
echo "Data/Hora: $(date)"
echo ""

# 1. Teste de Gateway
GATEWAY="192.168.10.1"
echo -n "[TESTE] Conexão com Gateway ($GATEWAY)... "
if ping -c 1 -W 2 $GATEWAY &> /dev/null; then
    echo "SUCCESS (PASS)"
else
    echo "FAILED (FAIL)"
fi

# 2. Teste de Servidor de Banco de Dados (Porta 3306)
DB_SERVER="10.0.0.5"
DB_PORT=3306
echo -n "[TESTE] Acesso ao Banco de Dados ($DB_SERVER:$DB_PORT)... "
if nc -zv -w 2 $DB_SERVER $DB_PORT &> /dev/null; then
    echo "SUCCESS (PASS)"
else
    echo "FAILED (FAIL)"
fi

# 3. Teste de Firewall - Garantir Isolamento da Rede Restrita (ATMs)
ATM_NET="172.16.0.10"
echo -n "[TESTE] Firewall: Bloqueio da Rede ATM ($ATM_NET)... "
if ping -c 1 -W 2 $ATM_NET &> /dev/null; then
    echo "FAILED - Risco de Segurança (FAIL)"
else
    echo "SUCCESS - Acesso Bloqueado pelo Firewall (PASS)"
fi

echo ""
echo "=================================================="
echo "   HEALTH CHECK CONCLUÍDO                         "
echo "=================================================="
