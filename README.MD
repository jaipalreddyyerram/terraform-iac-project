# Terraform IaC Project

## Overview
This project provisions AWS infrastructure using Terraform.

## Resources Created
- VPC
- Public Subnets
- Internet Gateway
- EC2 Instances
- S3 Bucket
- RDS Database

## Features
- Modular Terraform Architecture
- Dynamic Resource Creation
- Remote State Management
- Terraform Functions
- Policy-as-Code using OPA
- Resource Summary Outputs

## Workflow

Developer
   ↓
Terraform Init
   ↓
Terraform Plan
   ↓
OPA Policy Validation
   ↓
Terraform Apply
   ↓
AWS Resource Creation
   ↓
State Stored in S3
   ↓
Locking with DynamoDB

## Commands

### Initialize
terraform init

### Validate
terraform validate

### Plan
terraform plan

### Apply
terraform apply

### Destroy
terraform destroy

## Architecture
User → EC2 → Database → Storage

## Tools Used
- Terraform
- AWS
- OPA