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
	cp $(DOCKER-FILE) $(DIST)
	$(DOCKER) build -t=$(DOCKER-REPO) -f=$(DIST)/$(DOCKER-FILE) $(DIST)

build: build-app build-image

run-docker:
	$(DOCKER) run -d -p 80:8080 --name articles $(DOCKER-REPO)

run: build run-doker

deploy-docker:
	# Assumes docker login
	$(DOCKER) tag -f $(DOCKER-REPO) $(DOCKER-REPO)
	$(DOCKER) push $(DOCKER-REPO)

deploy: deploy-docker

production: build deploy
