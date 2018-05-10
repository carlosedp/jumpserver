all: gensecret genconfig addsshkey deploy

addsshkey:
	kubectl create -f secret.yaml

deploy:
	kubectl create -f jumpserver-service.yaml
	kubectl create -f jumpserver-rc.yaml

remove:
	kubectl delete -f jumpserver-service.yaml
	kubectl delete -f jumpserver-rc.yaml

newkey:
	rm -f sshkeys/id_rsa*
	ssh-keygen -q -f sshkeys/id_rsa -N '' -t rsa 

gensecret:
	cp ~/.ssh/authorized_keys .
	KEY=$$(openssl enc -base64 -A < authorized_keys) ;\
	sed "s/PUBLIC_KEY/$${KEY}/" secret.yaml.tmpl > secret.yaml
	rm ./authorized_keys

genconfig:
	cp ~/.ssh/config .
	kubectl create secret generic ssh-config --from-file=config
	rm ./config

.PHONY: newkey gensecret genconfig addsshkey deploy remove
