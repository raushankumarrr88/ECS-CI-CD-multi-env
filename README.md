# Project Name - ECS-CI-CD-multi-env

## Overview
This project is designed to deploy and manage infrastructure using Terraform and Docker, leveraging AWS services like ECR, ALB, and CodeBuild. The repository contains Terraform configurations for creating AWS resources and a build pipeline to automate the build, push, and deployment of Docker containers.

## Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Setup and Usage](#setup-and-usage)
- [Build Pipeline](#build-pipeline)
- [Environment Variables](#environment-variables)
- [Terraform Setup](#terraform-setup)
- [Docker Image Build and Push](#docker-image-build-and-push)
- [Contributing](#contributing)
- [License](#license)

## Architecture
The architecture includes:
- **AWS Elastic Container Registry (ECR)** for storing Docker images.
- **Application Load Balancer (ALB)** for routing traffic to the Docker containers.
- **AWS CodeBuild** for automating the build and deployment process.

## Prerequisites
- **AWS Account** with permissions to create and manage the necessary resources.
- **Docker** installed and configured locally.
- **Terraform** installed (instructions for installing are included in the pipeline).
- **AWS CLI** configured with appropriate IAM permissions.
- **Git** for version control.

## Directory Structure
```plaintext
project-root/
├── devops/
│   ├── terraform/
│   │   ├── main.tf              # Main Terraform configuration
│   │   ├── variables.tf          # Variable definitions
│   │   ├── outputs.tf            # Output definitions
│   │   └── ... (other Terraform config files)
├── src/
│   ├── app/                      # Application code
│   ├── Dockerfile                # Dockerfile for containerizing the application
├── buildspec.yml                 # Build specification for CodeBuild
└── README.md                     # Project documentation


Setup and Usage
Cloning the Repository
To start, clone this repository using:


git clone https://github.com/yourusername/your-repository.git
cd your-repository
Build Pipeline
This project uses AWS CodeBuild for CI/CD to automate the following steps:

Terraform Initialization: Initialize and plan the Terraform configurations.
Docker Build: Build the Docker image using the application code.
Docker Push: Push the Docker image to Amazon ECR.
Terraform Apply: Apply the infrastructure changes to AWS.
Environment Variables
The following environment variables are used in the CodeBuild pipeline and Terraform:

AWS_DEFAULT_REGION: The AWS region where resources are created.
AWS_ACCOUNT_ID: The AWS account ID for ECR and other resources.
ECR_REPOSITORY_NAME: Name of the ECR repository.
CODEBUILD_BUILD_ID: Provided by CodeBuild, used as an image tag.
DESTROY_RESOURCES (optional): Set to "true" to trigger a terraform destroy.
Terraform Setup
Initialize Terraform:


cd devops/terraform
terraform init
Plan the Infrastructure:


terraform plan -var "aws_region=your-region" -var "ecr_repository_name=your-repo-name" -var "aws_account_id=your-account-id" -var "image_tag=your-image-tag"
Apply the Infrastructure Changes:


terraform apply -auto-approve -var "aws_region=your-region" -var "ecr_repository_name=your-repo-name" -var "aws_account_id=your-account-id" -var "image_tag=your-image-tag"
Destroy the Infrastructure (optional):


terraform destroy -auto-approve -var "aws_region=your-region" -var "ecr_repository_name=your-repo-name" -var "aws_account_id=your-account-id" -var "image_tag=your-image-tag"
Docker Image Build and Push
Build Docker Image:


docker build -t your-ecr-repo:latest .
Tag Docker Image:


docker tag your-ecr-repo:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/your-ecr-repo:latest
Push Docker Image to ECR:


aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/your-ecr-repo:latest
Contributing
To contribute to this project:

Fork the repository.
Create a feature branch (git checkout -b feature/YourFeature).
Commit your changes (git commit -m 'Add some feature').
Push to the branch (git push origin feature/YourFeature).
Open a Pull Request.


This project is licensed under the MIT License - see the LICENSE file for details.

### Notes:
- Replace placeholder values (e.g., `your-repo-name`, `your-region`) with actual values relevant to your project.
- Add any additional information specific to your setup, such as specific dependencies or troubleshooting tips.
- Make sure that any sensitive information (such as actual account IDs or secrets) is either abstracted out or stored securely, not in the README.
```



## Setup and Usage
For using the project in your aws Account. Below are the steps:-
1: Create a Pipeline IN AWS code Pipeline
2: Create Three env Varibale int the build phase which will consist the AWS Account No, ECR Repo Name, Region
3. Trigger the pipeline and it will build all the infra


