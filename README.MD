# IaC Project using Terraform

## Overview
This project deploys cloud infrastructure using Terraform:
- VPC, Subnets
- EC2 Instance
- S3 Storage
- RDS Database
- Remote backend
- Policy enforcement (OPA)

## Steps to Run

1. Initialize
   terraform init

2. Plan
   terraform plan

3. Apply
   terraform apply

## Architecture
User → EC2 → Database → Storage

## Tools Used
- Terraform
- AWS
- OPA