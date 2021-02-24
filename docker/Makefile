ifndef PORT
override PORT = 8080
endif
ifndef DEPLOY_PORT
override DEPLOY_PORT = 9999
endif

build:
	make clean
	make compile
	docker build -t $(USERNAME)/nuxeo . | tee ./logs/build.log

start:
	docker run --name $(USERNAME)-nuxeo -p 8080:$(PORT) -t $(USERNAME)/nuxeo | tee ./logs/run.log

start-background:
	echo "Running on port $(DEPLOY_PORT)"
	docker run -d --name $(USERNAME)-nuxeo -p 8080:$(DEPLOY_PORT) -t $(USERNAME)/nuxeo | tee ./logs/run.log

run:
	make build
	make start

deploy:
	make build
	make start-background

console:
	docker run --name $(USERNAME)-console-nuxeo -it --rm $(USERNAME)/nuxeo bash

rm:
	docker stop $(USERNAME)-nuxeo
	docker rm $(USERNAME)-nuxeo
	
rmi:
	docker rmi $(USERNAME)/nuxeo

clean:
	make rm |:
	make rmi |:

compile:
	./scripts/package_build.sh | tee ./logs/packages_build.log


