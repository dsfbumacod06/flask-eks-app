.PHONY: preview-infra deploy-infra build-image push-image deploy-container

preview-infra:
	terraform -chdir=infra/terraform -var="rds_db_name=$DB_NAME" -var="rds_username=$DB_USERNAME" -var="rds_password=$DB_PASSWORD" init
	terraform -chdir=infra/terraform -var="rds_db_name=$DB_NAME" -var="rds_username=$DB_USERNAME" -var="rds_password=$DB_PASSWORD" validate
	terraform -chdir=infra/terraform -var="rds_db_name=$DB_NAME" -var="rds_username=$DB_USERNAME" -var="rds_password=$DB_PASSWORD" plan


deploy-infra:
	terraform -chdir=infra/terraform -var="rds_db_name=$DB_NAME" -var="rds_username=$DB_USERNAME" -var="rds_password=$DB_PASSWORD" apply -auto-approve

build-image:
	aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS \ 		
		--password-stdin 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com
	docker build -t {image name} {dockerfile location}

push-image:
# docker tag {image name}:{version} 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com/{image name}:{version#}
# docker push 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com/onebyzero/flask-app:1

deploy-container:
# Add a command line to deploy the container on the AWS EKS setup as part of infrastructure deployment
