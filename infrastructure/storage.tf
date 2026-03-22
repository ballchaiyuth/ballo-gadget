resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "gear_storage" {
  bucket = "ballo-gadget-gear-storage-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "BalloGadget Gear Storage"
  }
}

# Block public access (standard security practice)
resource "aws_s3_bucket_public_access_block" "gear_storage_block" {
  bucket = aws_s3_bucket.gear_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.gear_storage.id
}
