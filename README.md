# Sub-rede-Corporativa

## Projeto: Homologação e Validação de Sub-rede Corporativa

📌 Descrição do Projeto
Este projeto documenta o plano de testes e validação para a entrada da nova sub-rede de estações de trabalho (`192.168.10.0/24`) em ambiente de homologação (*Staging*), garantindo o isolamento correto frente à rede de Caixas Eletrônicos (`172.16.0.0/24`) e o acesso autorizado aos servidores centrais.

📐 Topologia Lógica do Ambiente
* **Rede de Origem (Estações):** `192.168.10.0/24`
* **Rede Restrita (ATMs/Caixas):** `172.16.0.0/24`
* **Servidor de Banco de Dados:** `10.0.0.5`
* **Gateway de Homologação:** `192.168.10.1`

🧪 Matriz de Testes de Conectividade (Health Check)

| ID do Teste | Origem | Destino | Protocolo/Porta | Resultado Esperado | Status no Staging |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-01** | `192.168.10.50` | `192.168.10.1` | ICMP (Ping) | Sucesso (Conexão Gateway) | PASS |
| **TC-02** | `192.168.10.50` | `10.0.0.5` | TCP / 3306 (MySQL) | Sucesso (Acesso ao DB) | PASS |
| **TC-03** | `192.168.10.50` | `172.16.0.10` | ICMP / Todos | Bloqueado (Firewall Deny) | PASS |

🚀 Script de Validação Automatizada (Bash)
Exemplo de comando executado durante o Health Check para validar portas ativas:

'''bash
# Teste de conectividade com a porta do servidor de banco de dados
nc -zv 10.0.0.5 3306

==================================================
   INICIANDO HEALTH CHECK - AMBIENTE DE STAGING   
==================================================
Data/Hora: Ter Oct 27 10:00:00 BRT 2026

[TESTE] Conexão com Gateway (192.168.10.1)... SUCCESS (PASS)
[TESTE] Acesso ao Banco de Dados (10.0.0.5:3306)... SUCCESS (PASS)
[TESTE] Firewall: Bloqueio da Rede ATM (172.16.0.10)... SUCCESS - Acesso Bloqueado pelo Firewall (PASS)

==================================================
   HEALTH CHECK CONCLUÍDO                         
==================================================
```
