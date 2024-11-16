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

deploy-container:
	kubectl apply -f ./deployment/manifests
