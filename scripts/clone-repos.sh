#!/bin/bash

# Verifica se os diretórios já existem
if [ ! -d "frontend" ]; then
    echo "Clonando repositório do frontend..."
    git clone https://github.com/ale-ambevtech/estudio-frontend.git frontend
fi

if [ ! -d "backend" ]; then
    echo "Clonando repositório do backend..."
    git clone https://github.com/ale-ambevtech/estudio-backend.git backend
fi 