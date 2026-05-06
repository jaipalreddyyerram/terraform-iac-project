package terraform.policy

# Deny S3 buckets without versioning
deny[msg] {
  input.resource_type == "aws_s3_bucket"
  not input.config.versioning.enabled
  msg = "S3 bucket must have versioning enabled"
}

# Deny public S3 buckets
deny[msg] {
  input.resource_type == "aws_s3_bucket"
  input.config.acl == "public-read"
  msg = "Public S3 buckets are not allowed"
}

# Deny EC2 instances not using approved types
deny[msg] {
  input.resource_type == "aws_instance"
  not allowed_instance_types[input.config.instance_type]
  msg = sprintf("Instance type %v is not allowed", [input.config.instance_type])
}

allowed_instance_types := {
  "t3.micro"
}

# Require tags on resources
deny[msg] {
  input.resource_type == "aws_instance"
  not input.config.tags.Name
  msg = "EC2 instances must have Name tags"
}

# Restrict deployment regions
deny[msg] {
  input.resource_type == "aws_instance"
  input.config.region != "ap-south-1"
  msg = "Resources must be deployed only in ap-south-1"
}