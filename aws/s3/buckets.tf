resource "aws_s3_bucket" "GradientFlowai-parquet-files" {
  bucket = "gradientflow-parquet-files"
  #  bucket_prefix = "gradientFlow-parquet-files-"
}

resource "aws_s3_bucket_acl" "parquet-acl" {
  bucket = aws_s3_bucket.GradientFlowai-parquet-files.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versioning_parquet_files" {
  bucket = aws_s3_bucket.GradientFlowai-parquet-files.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "allow_cors" {
  bucket = aws_s3_bucket.GradientFlowai-parquet-files.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*", "*gradient-flow-ai.vercel.app"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
