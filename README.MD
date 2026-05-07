# 🚀 Infrastructure as Code (IaC) for Core Cloud Resources using Terraform

## 📌 Project Overview

This project demonstrates a production-style Infrastructure as Code (IaC) implementation on AWS using Terraform.

The infrastructure is fully automated and modularized to provision core cloud resources including:

- VPC
- Public Subnets
- Internet Gateway
- Route Tables
- Security Groups
- EC2 Instances
- S3 Storage
- RDS Database
- Remote Backend
- Policy-as-Code using OPA

The project follows DevOps best practices such as:
- Modular Terraform architecture
- Remote state management
- State locking
- Dynamic resource provisioning
- Infrastructure outputs
- Security governance

---

# 🏗️ Architecture

```text
Developer
   ↓
Terraform Configuration
   ↓
Terraform Engine
   ↓
AWS Cloud Infrastructure
   ├── VPC
   ├── Public Subnets
   ├── Internet Gateway
   ├── Route Tables
   ├── Security Groups
   ├── EC2 Instances
   ├── S3 Bucket
   └── RDS Database
   ↓
Terraform State Stored in S3
   ↓
State Locking using DynamoDB
```

---

# 📂 Project Structure

```text
iac-project/
│
├── provider.tf
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── summary.tf
├── terraform.tfvars
├── README.md
├── .gitignore
│
├── policies/
│   └── policy.rego
│
├── modules/
│   │
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── storage/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── database/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

# ☁️ AWS Resources Created

| Resource | Description |
|---|---|
| VPC | Isolated cloud network |
| Public Subnets | Hosts EC2 instances |
| Internet Gateway | Internet connectivity |
| Route Table | Routing internet traffic |
| Security Group | Firewall rules |
| EC2 Instances | Virtual application servers |
| S3 Bucket | Object storage |
| RDS MySQL | Managed relational database |
| DynamoDB Table | Terraform state locking |
| S3 Backend | Remote Terraform state |

---

# ⚙️ Features

## ✅ Infrastructure as Code
All infrastructure is written using Terraform configuration files.

## ✅ Modular Architecture
Infrastructure is separated into reusable Terraform modules.

## ✅ Dynamic Resource Creation
Resources are created dynamically using:
- count
- length()
- element()
- format()
- cidrsubnet()

## ✅ Remote Backend
Terraform state is stored remotely in AWS S3.

## ✅ State Locking
DynamoDB prevents simultaneous Terraform modifications.

## ✅ Security Groups
Controls inbound and outbound traffic.

## ✅ Policy-as-Code
OPA validates infrastructure security policies.

## ✅ Resource Outputs
Displays infrastructure information after deployment.

---

# 🔐 Security Policies (OPA)

The project includes Open Policy Agent (OPA) policies to enforce infrastructure security standards.

## Policies Implemented

- S3 bucket versioning enforcement
- Restriction on insecure EC2 instance types
- Mandatory RDS encryption

---

# 📦 Terraform Built-in Functions Used

| Function | Purpose |
|---|---|
| length() | Count resources |
| format() | Dynamic naming |
| upper() | Uppercase names |
| merge() | Merge tags |
| element() | Select subnet |
| cidrsubnet() | Create dynamic subnets |

---

# 🌐 Networking Configuration

## VPC CIDR

```text
10.0.0.0/16
```

## Public Subnets

```text
10.0.1.0/24
10.0.2.0/24
```

## Allowed Ports

| Port | Purpose |
|---|---|
| 22 | SSH |
| 80 | HTTP |

---

# 🚀 Deployment Workflow

```text
Developer
   ↓
terraform init
   ↓
terraform validate
   ↓
terraform plan
   ↓
OPA Policy Validation
   ↓
terraform apply
   ↓
AWS Resource Creation
   ↓
Terraform State Stored in S3
   ↓
DynamoDB State Locking
```

---

# 🛠️ Prerequisites

Before running the project install:

- Terraform
- AWS CLI
- OPA

---

# 🔧 AWS Configuration

Configure AWS CLI:

```bash
aws configure
```

Provide:
- AWS Access Key
- AWS Secret Key
- Region → ap-south-1

---

# ☁️ Create Backend Resources

## Create S3 Bucket

```bash
aws s3 mb s3://your-terraform-state-bucket --region ap-south-1
```

## Create DynamoDB Table

```bash
aws dynamodb create-table \
  --table-name terraform-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
```

---

# ▶️ How to Run the Project

## 1️⃣ Initialize Terraform

```bash
terraform init
```

---

## 2️⃣ Validate Configuration

```bash
terraform validate
```

---

## 3️⃣ Preview Infrastructure

```bash
terraform plan
```

---

## 4️⃣ Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

---

# 📊 Outputs

After successful deployment:

```text
deployment_time
instance_ips
resource_summary
```

Example:

```text
resource_summary = {
  databases = 1
  instances = 2
  s3_buckets = 1
  subnets = 2
  vpcs = 1
}
```

---

# 🧹 Destroy Infrastructure

To avoid AWS charges:

```bash
terraform destroy
```

---

# 📈 Future Improvements

- Load Balancer
- Auto Scaling
- NAT Gateway
- Private Subnets
- CI/CD Integration
- Kubernetes Deployment
- Monitoring with CloudWatch
- Multi-environment setup

---

# 🎯 Learning Outcomes

This project demonstrates:

- Infrastructure as Code (IaC)
- Terraform Modules
- AWS Networking
- Cloud Automation
- Remote State Management
- DevOps Best Practices
- Security Governance
- Policy-as-Code

---

# 👨‍💻 Author

Jaipal Reddy Yerram
