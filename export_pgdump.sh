#!/bin/bash

source ./.env.sh

SCRIPT="
#!/bin/bash

echo '$(date +%F_%T) - SSH to ${USERNAME}@${HOSTNAME} successful!';

echo ''
echo 'Containers found:';
docker ps | grep '${DOCKER_CONTAINER}';

echo ''
echo 'Taking dump...';
docker exec ${DOCKER_CONTAINER} pg_dump -U ${DB_USER} --data-only -d ${DB_DATABASE} > ${BACKUP_FILE_PATH}

echo ''
echo 'Dump finished.. Compressing..'
cd ${BACKUP_PATH}
tar -cvzf ${COMPRESSED_FILE} ${BACKUP_FILE}

echo ''
echo 'Logging out from server..'
exit 0;"

ssh -l ${USERNAME} ${HOSTNAME} -p ${PORT} "${SCRIPT}"
echo "Downloading file..."
scp ${USERNAME}@${HOSTNAME}:${BACKUP_PATH}/${COMPRESSED_FILE} ./pg-dump/

# Now that we have file, we can split it into chunks
echo "Splitting files into chunk of 100.."
cd ./pg-dump
split -b100M --verbose ${COMPRESSED_FILE} ./split/${COMPRESSED_FILE}.


echo ""
echo "Cleaning up files from server.."
SCRIPT="
#!/bin/bash
rm ${BACKUP_PATH}/${BACKUP_FILE}*
exit 0;"

ssh -l ${USERNAME} ${HOSTNAME} -p ${PORT} "${SCRIPT}"

echo ""
echo "Finished.."

#docker exec ${DOCKER_CONTAINER} pg_dump -U ${DB_USER} --column-inserts --data-only --rows-per-insert 1000 -d ${DB_DATABASE} > ${BACKUP_FILE_PATH}