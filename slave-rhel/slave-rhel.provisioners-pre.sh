sudo yum -y update
sudo yum -y install wget zip unzip
export REMOTE_FILES_FOLDER=/tmp/remotefiles
sudo rm -rf ${REMOTE_FILES_FOLDER}
sudo mkdir ${REMOTE_FILES_FOLDER}
sudo chmod 0777 ${REMOTE_FILES_FOLDER}
ls -ltr ${REMOTE_FILES_FOLDER}
echo ' ******** Pre-Steps Completed ********'