echo '****************************************************'
echo 'I am REDHAT SLAVE. I will install JAVA, MAVEN, GIT.'
echo '****************************************************'
echo '****** Jenkins URL config ******'
export JDK_PACKAGE_NAME=java-1.8.0-openjdk-devel
export MAVEN_DISTR_URL=https://www-us.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
echo '**********Setting Environment: Start**********************'
export JENKINS_SLAVE_SCRIPT=slave-register.sh
export JENKINS_SLAVE_SERVICE=rhel-jenkins-slave.service
export SLAVE_LABEL=rhel-jenkins-slave
export REMOTE_FILES_FOLDER=/tmp/remotefiles
export SUDO_USER_NAME=ec2-user
export JAVA_HOME=/usr/lib/jvm/java/jre
export JAVA_BIN_LINK=/usr/bin/java
export SLAVE_JENKINS_DIR=/var/jenkins
echo '**********Setting Environment: End**********************'
sudo yum -y install git
sudo mkdir /tmp/repofiles
echo '********** Java Setups: Start **********************'
sudo yum -y install ${JDK_PACKAGE_NAME}
sudo mkdir /tmp/repofiles/java
sudo mkdir /tmp/repofiles/java/jdk7
sudo mkdir /tmp/repofiles/java/jdk8
echo '********** Java Setups: End **********************'
echo '********** Maven Setups: Start **********************'
sudo mkdir /tmp/repofiles/maven
sudo wget ${MAVEN_DISTR_URL} -P /tmp/repofiles/maven/
cd /tmp/repofiles/maven/ && sudo tar -xf apache-maven-*.gz
sudo mkdir /usr/lib/maven
sudo mv /tmp/repofiles/maven/apache-maven-*/* /usr/lib/maven/
cd /tmp/repofiles/
sudo rm -rf /tmp/repofiles/maven
sudo cp -rf ${REMOTE_FILES_FOLDER}/maven.sh /etc/profile.d/
echo '********** Maven Setups: End **********************'
# sudo mv /usr/lib/jvm/java-*/ /usr/lib/jvm/java
# sudo ln -sfn /usr/lib/jvm/java/jre/bin/java /usr/bin/java
sudo mkdir ${SLAVE_JENKINS_DIR}
sudo cp -rf ${REMOTE_FILES_FOLDER}/jenkins-slave-auto-register.sh ${SLAVE_JENKINS_DIR}/
sudo cp -rf ${REMOTE_FILES_FOLDER}/slave-register.sh ${SLAVE_JENKINS_DIR}/
sudo cp -rf ${REMOTE_FILES_FOLDER}/${JENKINS_SLAVE_SERVICE} /etc/systemd/system/
sudo chmod -R 777 ${SLAVE_JENKINS_DIR}
cd ${SLAVE_JENKINS_DIR}
sudo chown -R ${SUDO_USER_NAME}:${SUDO_USER_NAME} ${SLAVE_JENKINS_DIR}/
sudo systemctl daemon-reload
sudo systemctl enable ${JENKINS_SLAVE_SERVICE}
# sudo cat ${SLAVE_JENKINS_DIR}/slave-register.sh
# sudo systemctl start ${JENKINS_SLAVE_SERVICE}
# sleep 10
# sudo systemctl status ${JENKINS_SLAVE_SERVICE}
# echo 'Jenkins Slave launch success'