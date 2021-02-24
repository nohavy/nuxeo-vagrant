ifndef PORT
override PORT = 8080
endif
ifndef DEPLOY_PORT
override DEPLOY_PORT = 9998
endif

build:
	make clean
	make compile |:
	docker build -t $$(whoami)/nuxeo . | tee ./logs/build.log

start:
	docker run --name $$(whoami)-nuxeo -p 8080:$(PORT) -t $$(whoami)/nuxeo | tee ./logs/run.log

start-background:
	echo "Running on port $(DEPLOY_PORT)"
	docker run -di --name $$(whoami)-nuxeo -p 8080:$(DEPLOY_PORT) -t $$(whoami)/nuxeo --restart unless-stopped httpd

run:
	make build
	make start

deploy:
	make build
	make start-background

console:
	docker run --name $$(whoami)-console-nuxeo -it --rm $$(whoami)/nuxeo bash

rm:
	docker stop $$(whoami)-nuxeo
	docker rm $$(whoami)-nuxeo
	
rmi:
	docker rmi $$(whoami)/nuxeo

clean:
	make rm |:
	make rmi |:

compile:
	./scripts/package_build.sh | tee ./logs/packages_build.log


