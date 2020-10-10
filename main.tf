data "aws_caller_identity" "current" {}
// data "aws_iam_account_alias" "current" {}
// data "aws_partition" "current" {}

provider "aws" {
  alias = "ses_region"
  region = var.ses_region
}
#
# SES Ruleset
#

# SES only allows one (just like Highlander and Lord of the Rings) rule set to
# be active at any point in time. So this will live in the app-global state file.
locals {
  email_domain             = "mail.${var.route53_domain_name}"
}

resource "aws_ses_receipt_rule_set" "main" {
  provider = aws.ses_region
  rule_set_name = var.ses_bucket
}

resource "aws_ses_active_receipt_rule_set" "main" {
  provider = aws.ses_region
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
}

#
# S3 bucket for receiving bounces
#

data "aws_iam_policy_document" "s3_allow_ses_puts" {
  statement {
    sid    = "allow-ses-put"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ses.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.ses_bucket}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:Referer"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket        = var.ses_bucket

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  acl           = "private"
  force_destroy = true
  policy        = data.aws_iam_policy_document.s3_allow_ses_puts.json

  logging {
    target_bucket = var.access_log_bucket
    target_prefix = "s3/${var.ses_bucket}/"
  }

  # When objects are overwritten don't preserve the earlier versions just in case
  versioning {
    enabled = true
  }

  # Never expire/delete anything from these buckets
  lifecycle_rule {
    prefix = ""
    enabled = false

    # Move old reports to cheaper storage after they are not needed
    transition {
      # 5 years
      days = 1825
      storage_class = "GLACIER"
    }
    noncurrent_version_transition {
      # 5 years
      days = 1825
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  # Block new public ACLs and uploading public objects
  block_public_acls = true

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true

  # Block new public bucket policies
  block_public_policy = true

  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}

#
# Route53
#

data "aws_route53_zone" "selected" {
  name         = var.route53_domain_name
  private_zone = var.private_zone
}

#
# SES Domain
#

module "ses_domain" {
  providers = {
    aws = aws.ses_region
  }
  source  = "trussworks/ses-domain/aws"
  version = "3.0.0"

  enable_incoming_email = var.enable_incoming_email

  domain_name     = var.route53_domain_name
  route53_zone_id = data.aws_route53_zone.selected.zone_id
  enable_verification = var.enable_verification

  from_addresses   = var.from_addresses
  mail_from_domain = local.email_domain

  dmarc_p = var.dmarc_p
  dmarc_rua = var.dmarc_rua
  receive_s3_bucket = aws_s3_bucket.bucket.id
  receive_s3_prefix = var.receive_s3_prefix
  enable_spf_record = var.enable_spf_record

  extra_ses_records = var.extra_ses_records

  ses_rule_set = aws_ses_receipt_rule_set.main.rule_set_name
}