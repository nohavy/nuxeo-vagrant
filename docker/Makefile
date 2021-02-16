build:
	docker build -t $(USERNAME)/nuxeo . | tee build.log

start:
	docker run --name $(USERNAME)-nuxeo -p 8080:8080 $(USERNAME)/nuxeo | tee run.log

# nuxeoctl console
console:
	docker run -it --rm $(USERNAME)/nuxeo bash

stop:
	docker stop $(USERNAME)-nuxeo
	


