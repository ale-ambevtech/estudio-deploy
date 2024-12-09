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

# Configura as variáveis de ambiente
echo "Configurando variáveis de ambiente..."
chmod +x scripts/setup-env.sh
./scripts/setup-env.sh

# Inicia os containers
echo "Iniciando a aplicação..."
chmod +x scripts/run.sh
./scripts/run.sh
