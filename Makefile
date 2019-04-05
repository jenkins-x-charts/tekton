CHART_REPO := http://jenkins-x-chartmuseum:8080
NAME := tekton
OS := $(shell uname)

CHARTMUSEUM_CREDS_USR := $(shell cat /builder/home/basic-auth-user.json)
CHARTMUSEUM_CREDS_PSW := $(shell cat /builder/home/basic-auth-pass.json)

init:
	helm init --client-only

setup: init
	helm repo add jenkinsxio http://chartmuseum.jenkins-x.io

build: clean setup
	helm dependency build tekton
	helm lint tekton

install: clean build
	helm upgrade ${NAME} tekton --install

upgrade: clean build
	helm upgrade ${NAME} tekton --install

delete:
	helm delete --purge ${NAME} tekton

clean:
	rm -rf tekton/charts
	rm -rf tekton/${NAME}*.tgz
	rm -rf tekton/requirements.lock

release: clean build
ifeq ($(OS),Darwin)
	sed -i "" -e "s/version:.*/version: $(VERSION)/" tekton/Chart.yaml

else ifeq ($(OS),Linux)
	sed -i -e "s/version:.*/version: $(VERSION)/" tekton/Chart.yaml
else
	exit -1
endif
	helm package tekton
	curl --fail -u $(CHARTMUSEUM_CREDS_USR):$(CHARTMUSEUM_CREDS_PSW) --data-binary "@$(NAME)-$(VERSION).tgz" $(CHART_REPO)/api/charts
	rm -rf ${NAME}*.tgz
