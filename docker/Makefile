build:
	make rm |:
	make rmi |:
	docker build -t $(USERNAME)/nuxeo . | tee build.log

start:
	docker run --name $(USERNAME)-nuxeo -p 8080:8080 -t $(USERNAME)/nuxeo | tee run.log

console:
	docker run --name $(USERNAME)-console-nuxeo -it --rm $(USERNAME)/nuxeo bash

rm:
	docker stop $(USERNAME)-nuxeo
	docker rm $(USERNAME)-nuxeo
	
rmi:
	docker rmi $(USERNAME)/nuxeo

