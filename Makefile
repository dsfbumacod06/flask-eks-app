.PHONY: deploy-infra build-image push-image extract-artifacts install-kubectl create-manifests deploy-container 

deploy-infra:
	terraform -chdir=infra/terraform init
	terraform -chdir=infra/terraform validate
	terraform -chdir=infra/terraform plan \
		-var="rds_db_name=$(DB_NAME)" \
		-var="rds_username=$(DB_USERNAME)" \
		-var="rds_password=$(DB_PASSWORD)" \
		-var="rds_port=$(DB_PORT)" \
		-no-color
	terraform -chdir=infra/terraform apply \
		-var="rds_db_name=$(DB_NAME)" \
		-var="rds_username=$(DB_USERNAME)" \
		-var="rds_password=$(DB_PASSWORD)" \
		-var="rds_port=$(DB_PORT)" \
		-no-color \
		--auto-approve \
		| grep -v '::debug::' \
		| grep -v '::set-output name=stdout::' \
		| tee deployment-results.txt

create-infra-artifact:
	CLUSTER_NAME=$( \
		awk '/Outputs/{flag=1; next} flag' deployment-results.txt \
		| grep 'cluster_name' \
		| sed 's/cluster_name = "//' \
		| sed 's/"//' \
	)
	echo "EKS_CLUSTER_NAME=$(CLUSTER_NAME)" > infra-artifact.txt;
	DB_ENDPOINT=$( \
		awk '/Outputs/{flag=1; next} flag' deployment-results.txt \
		| grep 'rds_postsgres_db_endpoint' \
		| sed 's/rds_postsgres_db_endpoint = "//' \
		| sed 's/:$(DB_PORT)"//' \
	)
	echo "RDS_ENDPOINT=$(DB_ENDPOINT)"  >> infra-artifact.txt; 


build-image:
	docker build -t $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)  ./app

push-image:
	docker push $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)

extract-artifacts:
	echo "$(cat infra-artifact/infra-artifact.txt | grep 'EKS_CLUSTER_NAME')" >> $(GITHUB_ENV)
	echo "$(cat infra-artifact/infra-artifact.txt | grep 'RDS_ENDPOINT')" >> $(GITHUB_ENV)

install-kubectl:
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	kubectl version --client
create-manifests:
	mkdir ./deployment/manifests
	sed "s/RDS.ENDPOINT/$(RDS_ENDPOINT)/g" ./deployment/manifests-templates/external-service.yaml > ./deployment/manifests/external-service.yaml

deploy-container:
	helm upgrade --install obz-flask-app \
		./deployment/helm-charts/flask-app/ \
			--set image.tag="$(IMAGE_TAG)" \
			--wait --timeout 30s --atomic
	kubectl apply -f ./deployment/manifests
