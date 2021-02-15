start:
	make clean
	vagrant up --provision

debug:
	make clean
	vagrant up --provision --debug > log.txt

clean:
	vagrant destroy --force

ssh:
	vagrant ssh