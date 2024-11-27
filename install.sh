#!/bin/bash

# Vai para o diretório do script
cd "$(dirname "$0")"

# Verifica se o Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi

# Verifica se o Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo "Instalando Docker Compose..."
    sudo apt-get update
    sudo apt-get install -y docker-compose
fi

# Clona ou atualiza os repositórios
chmod +x scripts/clone-repos.sh
./scripts/clone-repos.sh

# Obtém o IP do Raspberry Pi
IP=$(hostname -I | awk '{print $1}')

# Cria ou atualiza o arquivo .env
echo "HOST_IP=$IP" > .env
echo "FRONTEND_PORT=3000" >> .env
echo "BACKEND_PORT=8000" >> .env

# Inicia os containers
docker-compose up -d --build

echo "Instalação concluída!"
echo "Acesse a aplicação em: http://$IP:3000" 
