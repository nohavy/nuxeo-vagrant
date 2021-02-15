start:
	vagrant up --provision

debug:
	vagrant up --provision --debug > log.txt

clean:
	vagrant destroy
