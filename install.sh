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

# Inicia os containers usando docker compose
echo "Iniciando containers..."
docker compose up -d --build

echo "Instalação concluída!"
echo "Acesse a aplicação em: http://$IP:3000"
