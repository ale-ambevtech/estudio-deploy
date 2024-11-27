#!/bin/bash

# Vai para o diretório do script
cd "$(dirname "$0")"

# Verifica se o Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker não encontrado. Por favor, instale o Docker primeiro."
    exit 1
else
    echo "Docker já está instalado"
fi

# Verifica se docker compose está disponível
if ! docker compose version &> /dev/null; then
    echo "Docker Compose não encontrado. Por favor, instale o Docker Compose primeiro."
    exit 1
else
    echo "Docker Compose já está instalado"
fi

# Clona ou atualiza os repositórios
echo "Clonando/atualizando repositórios..."
chmod +x scripts/clone-repos.sh
./scripts/clone-repos.sh

# Obtém o IP do Raspberry Pi
IP=$(hostname -I | awk '{print $1}')
BACKEND_PORT=8000

# Cria ou atualiza o arquivo .env do deploy
echo "Configurando variáveis de ambiente do deploy..."
echo "HOST_IP=$IP" > .env
echo "FRONTEND_PORT=3000" >> .env
echo "BACKEND_PORT=$BACKEND_PORT" >> .env

# Cria ou atualiza o arquivo .env do frontend
echo "Configurando variáveis de ambiente do frontend..."
echo "VITE_API_BASE_URL=http://$IP:$BACKEND_PORT/api/v1" > frontend/.env
echo "VITE_WS_URL=ws://$IP:$BACKEND_PORT/api/v1/ws/metadata" >> frontend/.env

# Inicia os containers usando docker compose
echo "Iniciando containers..."
docker compose up -d --build

echo "Instalação concluída!"
echo "Acesse a aplicação em: http://$IP:3000"
