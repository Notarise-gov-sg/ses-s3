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
| enable\_spf\_record | n/a | `bool` | `false` | no |
| enable\_verification | Control whether or not to verify SES DNS records. | `bool` | `true` | no |
| from\_addresses | n/a | `list` | n/a | yes |
| private\_zone | n/a | `bool` | `false` | no |
| region | n/a | `string` | n/a | yes |
| route53\_domain\_name | n/a | `string` | n/a | yes |
| ses\_bucket | n/a | `string` | n/a | yes |
| ses\_bucket\_prefix | Prefix folder path for all emails receive for this receipt rule | `string` | n/a | yes |
| ses\_bucket\_storage\_region | S3 bucket region where emails are stored | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ses\_identity\_arn | SES identity ARN. |

