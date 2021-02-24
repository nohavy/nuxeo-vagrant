ifndef PORT
override PORT = 8080
endif

build:
	make rm |:
	make rmi |:
	make compile
	docker build -t $(USERNAME)/nuxeo . | tee ./logs/build.log

start:
	docker run --name $(USERNAME)-nuxeo -p 8080:$(PORT) -t $(USERNAME)/nuxeo | tee ./logs/run.log

run:
	make build
	make start

console:
	docker run --name $(USERNAME)-console-nuxeo -it --rm $(USERNAME)/nuxeo bash

rm:
	docker stop $(USERNAME)-nuxeo
	docker rm $(USERNAME)-nuxeo
	
rmi:
	docker rmi $(USERNAME)/nuxeo

compile:
	./scripts/package_build.sh | tee ./logs/packages_build.log
