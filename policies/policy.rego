package terraform.policy

deny contains msg if {
    input.resource_type == "aws_s3_bucket"
    not input.config.versioning.enabled
    msg := "S3 bucket versioning must be enabled"
}

deny contains msg if {
    input.resource_type == "aws_instance"
    input.config.instance_type == "t2.nano"
    msg := "t2.nano instances are not allowed"
}

deny contains msg if {
    input.resource_type == "aws_db_instance"
    not input.config.storage_encrypted
    msg := "RDS storage encryption must be enabled"
}