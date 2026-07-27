terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


# S3 Bucket


resource "aws_s3_bucket" "qr_bucket" {
  bucket = "qr-phishing-storage-demo-12345"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.qr_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.qr_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.qr_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# DynamoDB


resource "aws_dynamodb_table" "scan_results" {

  name         = "QRScanResults"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "ScanId"

  attribute {
    name = "ScanId"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Project = "QRPhishing"
  }
}


# IAM Role


resource "aws_iam_role" "lambda_role" {

  name = "qr-phishing-lambda-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"

        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


# IAM Policy


resource "aws_iam_policy" "lambda_policy" {

  name = "QRPhishingPolicy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = "${aws_s3_bucket.qr_bucket.arn}/*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.qr_bucket.arn
      },

      {
        Effect = "Allow"

        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]

        Resource = aws_dynamodb_table.scan_results.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {

  role       = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_policy.arn
}


# CloudWatch


resource "aws_cloudwatch_log_group" "lambda_logs" {

  name              = "/aws/lambda/qr-phishing-detector"

  retention_in_days = 14
}


# Lambda


resource "aws_lambda_function" "qr_detector" {

  function_name = "QRPhishingDetector"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename         = "lambda_function.zip"

  source_code_hash = filebase64sha256("lambda_function.zip")

  timeout = 60

  memory_size = 512

  environment {

    variables = {

      BUCKET_NAME = aws_s3_bucket.qr_bucket.bucket

      TABLE_NAME = aws_dynamodb_table.scan_results.name
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda_logs
  ]
}


# Outputs


output "bucket_name" {
  value = aws_s3_bucket.qr_bucket.bucket
}

output "lambda_name" {
  value = aws_lambda_function.qr_detector.function_name
}

output "dynamodb_table" {
  value = aws_dynamodb_table.scan_results.name
}

output "lambda_role" {
  value = aws_iam_role.lambda_role.arn
}
