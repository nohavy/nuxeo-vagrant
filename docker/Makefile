ifndef PORT
override PORT = 8080
endif
ifndef DEPLOY_PORT
override DEPLOY_PORT = 9998
endif

build:
	make clean
	make compile |:
	docker build -t 3d.investigation/nuxeo . | tee ./logs/build.log

start:
	docker run --name 3d.investigation-nuxeo -p 8080:$(PORT) -t 3d.investigation/nuxeo | tee ./logs/run.log

start-background:
	echo "Running on port $(DEPLOY_PORT)"
	docker run -di --name 3d.investigation-nuxeo -p 8080:$(DEPLOY_PORT) -t 3d.investigation/nuxeo --restart unless-stopped httpd

run:
	make build
	make start

deploy:
	make build
	make start-background

console:
	docker run --name 3d.investigation-console-nuxeo -it --rm 3d.investigation/nuxeo bash

rm:
	docker stop 3d.investigation-nuxeo
	docker rm 3d.investigation-nuxeo
	
rmi:
	docker rmi 3d.investigation/nuxeo

clean:
	make rm |:
	make rmi |:

compile:
	./scripts/package_build.sh | tee ./logs/packages_build.log


