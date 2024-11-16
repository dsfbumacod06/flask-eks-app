.PHONY: preview-infra deploy-infra build-image push-image deploy-container

preview-infra:
	terraform -chdir=infra/terraform init
	terraform -chdir=infra/terraform validate
	terraform -chdir=infra/terraform plan -input=false


deploy-infra:
	terraform -chdir=infra/terraform apply -auto-approve -input=false

build-image:
	aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS \ 		
		--password-stdin 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com
	docker build -t {image name} {dockerfile location}

push-image:
# docker tag {image name}:{version} 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com/{image name}:{version#}
# docker push 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com/onebyzero/flask-app:1

deploy-container:
# Add a command line to deploy the container on the AWS EKS setup as part of infrastructure deployment
