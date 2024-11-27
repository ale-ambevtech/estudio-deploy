#!/bin/bash

# Vai para o diretório raiz do projeto
cd "$(dirname "$0")/.."

echo "Atualizando repositórios..."

# Atualiza o repositório de deploy
git pull

# Atualiza o frontend
cd frontend
git pull
cd ..

# Atualiza o backend
cd backend
git pull
cd ..

# Recria os containers
docker-compose down
docker-compose up -d --build

echo "Atualização concluída!" 