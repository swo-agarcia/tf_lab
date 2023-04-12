# Configuracion que contiene los recursos para definir el Backend

# Bucket que contiene los TF State
resource "aws_s3_bucket" "bucket-state" {
    bucket = "s3-dev-aws-${var.account}-backend"
    object_lock_enabled = true

    tags = {
        Description  = "Bucket que almacena el backend de Terraform en la cuenta"
        Environment  = "Desarrollo"
        CreationDate = var.date

    }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.bucket-state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Tabla Dynamo para guardar los LOCK FILE

resource "aws_dynamodb_table" "terraform-lock" {
    name           = "dynamodb-dev-aws-${var.account}-backend"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    server_side_encryption {
        enabled = true
    }

    tags = {
    Description  = "Tabla que almacena el backend de Terraform en la cuenta"
    Environment  = "Desarrollo"
    CreationDate = var.date
    }
}