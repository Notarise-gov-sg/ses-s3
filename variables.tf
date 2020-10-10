variable "access_log_bucket" {
  type        = string
  description = "Seperate Bucket to write access logs to"
}

variable "route53_domain_name" {
  type = string
}

variable "private_zone" {
  type    = bool
  default = false
}

variable "ses_region" {
  type = string
}

variable "ses_bucket" {
  type = string
}

variable "ses_bucket_region" {
  type = string
  description = "S3 bucket region where emails are stored"
}

# Variables for module

variable "dmarc_p" {
  description = "DMARC Policy for organizational domains (none, quarantine, reject)."
  type        = string
  default     = "none"
}

variable "dmarc_rua" {
  description = "DMARC Reporting URI of aggregate reports, expects an email address."
  type        = string
}

variable "enable_verification" {
  description = "Control whether or not to verify SES DNS records."
  type        = bool
  default     = true
}

variable "from_addresses" {
  description = "List of email addresses to catch bounces and rejections."
  type        = list(string)
}

variable "receive_s3_bucket" {
  description = "Name of the S3 bucket to store received emails (required if enable_incoming_email is true)."
  type        = string
  default     = ""
}

variable "receive_s3_prefix" {
  description = "The key prefix of the S3 bucket to store received emails (required if enable_incoming_email is true)."
  type        = string
  default     = ""
}

variable "enable_incoming_email" {
  description = "Control whether or not to handle incoming emails."
  type        = bool
  default     = true
}

variable "enable_spf_record" {
  description = "Control whether or not to set SPF records."
  type        = bool
  default     = true
}

variable "extra_ses_records" {
  description = "Extra records to add to the _amazonses TXT record."
  type        = list(string)
  default     = []
}