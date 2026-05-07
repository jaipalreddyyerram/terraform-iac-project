resource "aws_s3_bucket" "storage" {
  bucket = "your-unique-iac-storage-bucket"

  tags = merge(
    var.common_tags,
    {
      Name = "iac-storage"
    }
  )
}