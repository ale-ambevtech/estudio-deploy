#!/bin/bash

# Função para obter IP baseado no sistema operacional
get_ip() {
    case "$(uname -s)" in
        Darwin*)    # Mac OS X
            IP=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
            ;;
        Linux*)     # Linux (Raspberry Pi)
            IP=$(hostname -I | cut -d' ' -f1)
            ;;
        *)
            echo "Sistema operacional não suportado"
            exit 1
            ;;
    esac
    echo $IP
}

# Obtém o IP
IP=$(get_ip)
if [ -z "$IP" ]; then
    echo "Erro: Não foi possível obter o IP"
    exit 1
fi

BACKEND_PORT=8001

# Cria ou atualiza o arquivo .env do deploy
echo "Configurando variáveis de ambiente do deploy..."
echo "HOST_IP=$IP" > .env
echo "FRONTEND_PORT=3000" >> .env
echo "BACKEND_PORT=$BACKEND_PORT" >> .env

# Cria ou atualiza o arquivo .env do frontend
echo "Configurando variáveis de ambiente do frontend..."
# Certifica-se que o diretório frontend existe
if [ ! -d "../frontend" ]; then
    echo "Erro: Diretório frontend não encontrado"
    exit 1
fi

# Cria o arquivo .env no frontend
echo "VITE_API_BASE_URL=http://$IP:$BACKEND_PORT/api/v1" > ../frontend/.env
echo "VITE_WS_URL=ws://$IP:$BACKEND_PORT/api/v1/ws/metadata" >> ../frontend/.env

# Cria ou atualiza o arquivo .env do backend
echo "Configurando variáveis de ambiente do backend..."
if [ ! -d "../backend" ]; then
    echo "Erro: Diretório backend não encontrado"
    exit 1
fi

# Cria o arquivo .env no backend
echo "UPLOAD_DIR=uploads" > ../backend/.env
echo "DEBUG_DIR=debug" >> ../backend/.env
echo "MAX_FILE_SIZE=104857600" >> ../backend/.env
echo "CHUNK_SIZE=1048576" >> ../backend/.env
echo "CORS_ORIGINS=*" >> ../backend/.env

echo "Configuração de ambiente concluída!"
echo "IP configurado: $IP"
echo "Porta do backend: $BACKEND_PORT"
echo "Porta do frontend: 3000" 