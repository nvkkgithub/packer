#!/bin/bash

set -xe

JENKINS_MASTER_URL=$1
JENKINS_MASTER_SECRET=$2
SLAVE_NUM_EXECUTORS=$3
SLAVE_LABEL=$4
SLAVE_NODE_NAME=slave-rhel-$(date +%s)
SLAVE_DIRECTORY=/var/jenkins

# Download Agent JAR from master
sudo wget ${JENKINS_MASTER_URL}/jnlpJars/agent.jar -P ${SLAVE_DIRECTORY}

# Download CLI jar from the master
curl ${JENKINS_MASTER_URL}/jnlpJars/jenkins-cli.jar -o ~/jenkins-cli.jar

# Create node according to parameters passed in
cat <<EOF | java -jar ~/jenkins-cli.jar -auth "${JENKINS_MASTER_SECRET}" -s "${JENKINS_MASTER_URL}" create-node "${SLAVE_NODE_NAME}" |true
<slave>
  <name>${SLAVE_NODE_NAME}</name>
  <description></description>
  <remoteFS>/home/jenkins/agent</remoteFS>
  <numExecutors>${SLAVE_NUM_EXECUTORS}</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher">
    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>
  </launcher>
  <label>${SLAVE_LABEL}</label>
  <nodeProperties/>
  <userId>${USER}</userId>
</slave>
EOF
# Creating the node will fail if it already exists, so |true to suppress the
# error. This probably should check if the node exists first but it should be
# possible to see any startup errors if the node doesn't attach as expected.


# Run jnlp launcher
java -jar /var/jenkins/agent.jar -jnlpUrl ${JENKINS_MASTER_URL}/computer/${SLAVE_NODE_NAME}/slave-agent.jnlp -jnlpCredentials "${JENKINS_MASTER_SECRET}"