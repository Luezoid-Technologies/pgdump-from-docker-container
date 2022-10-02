# host server variables
USERNAME=xxxx
HOSTNAME=143.110.xxx.xx
PORT=xx

# script vars
DOCKER_CONTAINER="xxxx" # from where PG Dump to be taken
DB_USER="postgres"
DB_PASS="xxxx"
DB_DATABASE="postgres"
BACKUP_PATH="/root/dev/xxxx"
BACKUP_FILE="backup_db_$(date +%Y_%m_%d).sql"
BACKUP_FILE_PATH="${BACKUP_PATH}/${BACKUP_FILE}"
COMPRESSED_FILE="backup_db_$(date +%Y_%m_%d).sql.tar.gz"