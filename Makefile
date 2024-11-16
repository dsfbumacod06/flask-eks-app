.PHONY: preview-infra deploy-infra build-image push-image deploy-container

preview-infra:
	terraform -chdir=infra/terraform init
	terraform -chdir=infra/terraform validate
	terraform -chdir=infra/terraform plan \
		-var="rds_db_name=$(DB_NAME)" \
		-var="rds_username=$(DB_USERNAME)" \
		-var="rds_password=$(DB_PASSWORD)"

deploy-infra:
	terraform -chdir=infra/terraform apply \
	-var="rds_db_name=$(DB_NAME)" \
	-var="rds_username=$(DB_USERNAME)" \
	-var="rds_password=$(DB_PASSWORD)" \
	-auto-approve > deployment-results.txt



build-image:
	docker build -t $(ECR_REGISTRY)/$(ECR_REPOSITORY) app/
	docker tag $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG) $(ECR_REGISTRY)/$(ECR_REPOSITORY):latest

push-image:
	docker push $(ECR_REGISTRY)/$(ECR_REPOSITORY):latest

deploy-container:
# Add a command line to deploy the container on the AWS EKS setup as part of infrastructure deployment
