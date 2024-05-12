#!/bin/bash

# Defina as variáveis de conexão com o banco de dados
DB_SERVICE="db"
DB_NAME="pretix"
DB_USER="pretix"

# Caminho para o diretório de backup
BACKUP_DB_FILE="./backup/backup_$(date +"%Y%m%d_%H%M%S").dump"

# Executa dump da base de dados
docker compose exec $DB_SERVICE pg_dump -U $DB_USER -d $DB_NAME > $BACKUP_DB_FILE

echo "Backup $BACKUP_DB_FILE completo!"

# backup dos uploads do pretix
SERVICE_NAME="pretix"
# Nome e caminho completo para o arquivo tar.gz de backup
BACKUP_VOLUME_FILE="./backup/backup_$(date +"%Y%m%d_%H%M%S").tar.gz"

# Compacta e salva o backup dos uploads do pretix
docker compose exec $SERVICE_NAME tar -czf - /data > $BACKUP_VOLUME_FILE

echo "Backup $BACKUP_VOLUME_FILE completo"

