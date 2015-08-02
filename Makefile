SHELL=/bin/bash
HEXO=./node_modules/hexo/bin/hexo
DOCKER=/usr/local/bin/docker

# Configurable variables
DIST=./public
DOCKER-FILE=Dockerfile
DOCKER-REPO=jjperezaguinaga/articles
DOCKER-REGISTRY=tutum.co

build-app:
	$(HEXO) generate

build-image:
	$(DOCKER) build -t=$(DOCKER-REPO) $(DIST)

build: build-app build-image

deploy-docker:
	# Assumes docker login
	$(DOCKER) tag -f $(DOCKER-REPO) $(DOCKER-REGISTRY)/$(DOCKER-REPO)
	$(DOCKER) push $(DOCKER-REGISTRY)/$(DOCKER-REPO)

deploy: deploy-docker

production: build deploy
