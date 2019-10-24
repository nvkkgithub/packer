#!/bin/bash

export JENKINS_MASTER_URL=http://jenkins-url
export JENKINS_MASTER_SECRET=username:password
export JENKINS_SLAVE_EXEC_COUNT=15
export JENKINS_SLAVE_LABEL=rhel-jenkins-slave

sudo sh /var/jenkins/jenkins-slave-auto-register.sh ${JENKINS_MASTER_URL} ${JENKINS_MASTER_SECRET} ${JENKINS_SLAVE_EXEC_COUNT} ${JENKINS_SLAVE_LABEL}