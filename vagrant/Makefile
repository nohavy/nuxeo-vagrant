start:
	make clean
	vagrant up --provision | tee logs.log

debug:
	make clean
	vagrant up --provision --debug | tee logs.log

clean:
	vagrant destroy --force

ssh:
	vagrant ssh