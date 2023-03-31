resource "aws_s3_bucket" "GradientFlowai-parquet-files2" {
  bucket = "gradientflow-parquet-files"
  #  bucket_prefix = "gradientFlow-parquet-files-"
}

resource "aws_s3_bucket_acl" "parquet-acl" {
  bucket = aws_s3_bucket.GradientFlowai-parquet-files2.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versioning_parquet_files" {
  bucket = aws_s3_bucket.GradientFlowai-parquet-files2.id
  versioning_configuration {
    status = "Enabled"
  }
}
