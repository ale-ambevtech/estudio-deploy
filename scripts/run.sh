#!/bin/bash

# Vai para o diretório do script
cd "$(dirname "$0")/.."

# Verifica se o arquivo .env existe
if [ ! -f ".env" ]; then
    echo "Erro: Arquivo .env não encontrado. Execute setup-env.sh primeiro."
    exit 1
fi

# Inicia os containers usando docker compose
echo "Iniciando containers..."
docker compose up -d --build

# Obtém o IP do arquivo .env
IP=$(grep HOST_IP .env | cut -d'=' -f2)

echo "Containers iniciados com sucesso!"
echo "Acesse a aplicação em: http://$IP:3000" 