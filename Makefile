.PHONY: deploy-infra build-image push-image get-kubectl create-manifests deploy-container

deploy-infra:
	terraform -chdir=infra/terraform init
	terraform -chdir=infra/terraform validate
	terraform -chdir=infra/terraform plan \
		-var="rds_db_name=$(DB_NAME)" \
		-var="rds_username=$(DB_USERNAME)" \
		-var="rds_password=$(DB_PASSWORD)"
	terraform -chdir=infra/terraform apply \
	-var="rds_db_name=$(DB_NAME)" \
	-var="rds_username=$(DB_USERNAME)" \
	-var="rds_password=$(DB_PASSWORD)" \
	-auto-approve | tee deployment-results.txt

build-image:
	docker build -t $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)  ./app

push-image:
	docker push $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)

get-kubectl:
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	kubectl version --client


create-manifests:
	sed "s/IMAGE.NAME/$(IMAGE_NAME)/g" ./deployment/manifests-templates/deployment.yaml > ./deployment/manifests/deployment.yaml
	cat ./deployment/manifests/deployment.yaml
	sed "s/RDS.ENDPOINT/$(RDS_ENDPOINT)/g" ./deployment/manifests-templates/external-service.yaml > ./deployment/manifests/external-service.yaml
	cat ./deployment/manifests/external-service.yaml

deploy-container:
	kubectl apply -f ./deployment/manifests
