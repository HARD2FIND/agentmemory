#!/bin/bash
# Script de vérification de l'état des services

echo "{"
echo "  \"timestamp\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\","
echo "  \"services\": {"

# Vérification AgentMemory (Port 3111)
if nc -z localhost 3111 2>/dev/null; then
  echo "    \"agentmemory\": \"UP\","
else
  echo "    \"agentmemory\": \"DOWN\","
fi

# Vérification n8n (via URL configurée, ou port 5678 en local)
# Remplacez localhost:5678 par $URL_VPS_N8N si défini
if nc -z localhost 5678 2>/dev/null; then
  echo "    \"n8n\": \"UP\""
else
  echo "    \"n8n\": \"DOWN\""
fi

echo "  }"
echo "}"
