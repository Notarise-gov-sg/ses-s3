output "ses_identity_arn" {
  description = "SES identity ARN."
  value       = module.ses_domain.ses_identity_arn
}