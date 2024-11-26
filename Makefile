.PHONY: deploy-infra build-image push-image create-manifests deploy-container 

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

build-image:
	docker build -t $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)  ./app

push-image:
	docker push $(ECR_REGISTRY)/$(ECR_REPOSITORY):$(IMAGE_TAG)

create-manifests:
	mkdir ./deployment/manifests
	sed "s/RDS.ENDPOINT/$(RDS_ENDPOINT)/g" ./deployment/manifests-templates/external-service.yaml > ./deployment/manifests/external-service.yaml

deploy-container:
	helm upgrade --install obz-flask-app \
		./deployment/helm-charts/flask-app/ \
			--set image.tag="$(IMAGE_TAG)" \
			--wait --timeout 30s --atomic
	kubectl apply -f ./deployment/manifests
