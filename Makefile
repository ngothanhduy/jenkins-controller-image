APPLICATION_NAME ?= jenkins-controller
GIT_HASH ?= $(shell git rev-parse --short HEAD)

JENKINS_URL ?= http://localhost:8080/login
JENKINS_ADMIN_USR ?= admin
JENKINS_ADMIN_PSW ?= admin
DOCKERFILE ?= src/Dockerfile

build:
	@sudo docker build --tag ${APPLICATION_NAME}:${GIT_HASH} -f ${DOCKERFILE} .

deploy:
	@sudo docker run --rm --name ${APPLICATION_NAME}-machine -d -p 8080:8080 -p 50000:50000 \
	--env JENKINS_ADMIN_ID=${JENKINS_ADMIN_USR} \
	--env JENKINS_ADMIN_PASSWORD=${JENKINS_ADMIN_PSW} \
	--env JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
	${APPLICATION_NAME}:${GIT_HASH}
	@echo "==================================="
	@echo "Server:	${JENKINS_URL}"
	@echo "User:	${JENKINS_ADMIN_USR}"
	@echo "Pass:	${JENKINS_ADMIN_PSW}"
	@echo "==================================="

teardown:
	@sudo docker stop ${APPLICATION_NAME}-machine

cleanup:
	@sudo docker rmi ${APPLICATION_NAME}:${GIT_HASH}

cp_jobs:
	@sudo docker cp ${APPLICATION_NAME}-machine:/var/jenkins_home/jobs/DEMO jenkins_home/jobs/