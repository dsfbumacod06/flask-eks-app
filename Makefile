preview-infra:
	terraform -chdir=infra/terraform init
	terraform -chdir=infra/terraform validate
	terraform -chdir=infra/terraform plan -input=false


deploy-infra:
	terraform -chdir=infra/terraform apply -auto-approve -input=false

build-image:
# aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com
# docker build -t {image name} {dockerfile location}
# docker tag {image name}:{version#} 971422681412.dkr.ecr.ap-southeast-1.amazonaws.com/{image name}:{version#}
# test change - no tf actions dapat


# Add a command line to build the docker image

push-image:
# Add a command line to push the docker image to the registry

deploy-container:
# Add a command line to deploy the container on the AWS EKS setup as part of infrastructure deployment
