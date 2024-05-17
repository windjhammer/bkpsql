#! /usr/bin/env bash

CONTAINER_NAME="nome_do_container"
DB_USER="usuario_do_banco"
DB_PASSWORD="senha_do_banco"
DB_NAME="nome_do_banco"
BACKUP_DIR="/caminho/para/diretorio_de_backup"
BACKUP_DATE=$(date +"%d%m%Y%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_backup_${BACKUP_DATE}.sql"
COMPRESSED_BACKUP_FILE="${BACKUP_FILE}.gz"

mkdir -p "${BACKUP_DIR}"

docker exec "${CONTAINER_NAME}" mysqldump -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" >"${BACKUP_FILE}"

if [ $? -eq 0 ]; then
	echo "Backup realizado com sucesso: ${BACKUP_FILE}"

	gzip "${BACKUP_FILE}"

	if [ $? -eq 0 ]; then
		echo "Backup compactado com sucesso: ${COMPRESSED_BACKUP_FILE}"
	else
		echo "Erro ao compactar o backup"
	fi
else
	echo "Erro ao realizar o backup do banco de dados"
fi
