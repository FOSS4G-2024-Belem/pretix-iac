#!/bin/bash

# Defina o nome do serviço PostgreSQL no seu arquivo docker-compose.yml
DB_SERVICE="db"
# Defina as credenciais de conexão com o banco de dados
DB_NAME="pretix"
DB_USER="pretix"
DB_PASSWORD="pretixtest"

# Caminho para o arquivo de dump
LATEST_DB_BACKUP=$(ls -t ./backup | grep ".dump$" | head -n 1)

# Restaura o dump para o banco de dados
docker compose exec -T $DB_SERVICE psql -U $DB_USER -d $DB_NAME < ./backup/$LATEST_DB_BACKUP

echo "Restauração $LATEST_BACKUP completa"

SERVICE_NAME="pretix"
# Nome e caminho completo para o arquivo tar.gz de backup
LATEST_VOLUME_BACKUP=$(ls -t ./backup | grep ".tar.gz$" | head -n 1)

# Compacta e salva o backup dos uploads do pretix
docker compose exec $SERVICE_NAME sh -c "tar -xzvf ./backup/$LATEST_VOLUME_BACKUP -C /data"
#docker compose exec $SERVICE_NAME tar -xzf ./backup/$LATEST_VOLUME_BACKUP -C /data

