#!/bin/bash

# Verifica se os diretórios já existem
if [ ! -d "frontend" ]; then
    echo "Clonando repositório do frontend..."
    git clone <url-do-repo-frontend> frontend
fi

if [ ! -d "backend" ]; then
    echo "Clonando repositório do backend..."
    git clone <url-do-repo-backend> backend
fi 