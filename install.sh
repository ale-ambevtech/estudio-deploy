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

# Cria ou atualiza o arquivo .env
echo "Configurando variáveis de ambiente..."
echo "HOST_IP=$IP" > .env
echo "FRONTEND_PORT=3000" >> .env
echo "BACKEND_PORT=8000" >> .env

# Inicia os containers usando docker compose
echo "Iniciando containers..."
docker compose up -d --build

echo "Instalação concluída!"
echo "Acesse a aplicação em: http://$IP:3000"
