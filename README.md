# ses-s3

## Requirements

A s3 bucket for access logging

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| aws.ses\_region | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_log\_bucket | Seperate Bucket to write access logs to | `string` | n/a | yes |
| dmarc\_p | DMARC Policy for organizational domains (none, quarantine, reject). | `string` | `"none"` | no |
| dmarc\_rua | DMARC Reporting URI of aggregate reports, expects an email address. | `string` | n/a | yes |
| domain\_name | The domain name to configure SES. | `string` | n/a | yes |
| enable\_incoming\_email | Control whether or not to handle incoming emails. | `bool` | `true` | no |
| enable\_spf\_record | Control whether or not to set SPF records. | `bool` | `true` | no |
| enable\_verification | Control whether or not to verify SES DNS records. | `bool` | `true` | no |
| extra\_ses\_records | Extra records to add to the \_amazonses TXT record. | `list(string)` | `[]` | no |
| from\_addresses | List of email addresses to catch bounces and rejections. | `list(string)` | n/a | yes |
| mail\_from\_domain | Subdomain (of the route53 zone) which is to be used as MAIL FROM address | `string` | n/a | yes |
| private\_zone | n/a | `bool` | `false` | no |
| receive\_s3\_bucket | Name of the S3 bucket to store received emails (required if enable\_incoming\_email is true). | `string` | `""` | no |
| receive\_s3\_prefix | The key prefix of the S3 bucket to store received emails (required if enable\_incoming\_email is true). | `string` | `""` | no |
| region | n/a | `string` | n/a | yes |
| route53\_domain\_name | n/a | `string` | n/a | yes |
| route53\_zone\_id | Route53 host zone ID to enable SES. | `string` | n/a | yes |
| ses\_bucket | n/a | `string` | n/a | yes |
| ses\_bucket\_prefix | Prefix folder path for all emails receive for this receipt rule | `string` | n/a | yes |
| ses\_bucket\_storage\_region | S3 bucket region where emails are stored | `string` | n/a | yes |
| ses\_rule\_set | Name of the SES rule set to associate rules with. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ses\_identity\_arn | SES identity ARN. |

