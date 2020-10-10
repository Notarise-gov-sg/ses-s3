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

variable "region" {
  type = string
}

variable "ses_bucket" {
  type = string
}

variable "ses_bucket_prefix" {
  description = "Prefix folder path for all emails receive for this receipt rule"
  type = string
}

variable "ses_bucket_storage_region" {
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

variable "mail_from_domain" {
  description = " Subdomain (of the route53 zone) which is to be used as MAIL FROM address"
  type        = string
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

variable "route53_zone_id" {
  description = "Route53 host zone ID to enable SES."
  type        = string
}

variable "ses_rule_set" {
  description = "Name of the SES rule set to associate rules with."
  type        = string
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