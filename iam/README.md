## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> v0.14.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_permissions"></a> [iam\_permissions](#input\_iam\_permissions) | role policy document | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | app/service name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | kubernetes namespace where the service is running | `string` | n/a | yes |
| <a name="input_oidc_arn"></a> [oidc\_arn](#input\_oidc\_arn) | eks OpenID-Connect arn | `string` | n/a | yes |
| <a name="input_oidc_url"></a> [oidc\_url](#input\_oidc\_url) | eks cluster OpenID-Connect issuer URL | `string` | n/a | yes |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path for the role that we want to create | `string` | `"/"` | no |
| <a name="input_serviceaccount"></a> [serviceaccount](#input\_serviceaccount) | kubernetes service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | n/a |


## Example
```
variable "region" {
  default = "ap-south-1"
}

provider "aws" {
  region = var.region
}

module "app" {
  source         = "../modules/iam"
  name           = "app"
  role_path      = "/"
  oidc_url       = "oidc.eks.ap-south-1.amazonaws.com/id/<id>"
  oidc_arn       = "arn:aws:iam::<account_id>:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/<id>"
  namespace      = "default"
  serviceaccount = "app"

  iam_permissions = [
    {
      "actions" = [
      ],
      "resources" = []
    }
  ]
}

output "role_arn" {
    value = module.app.role_arn
}

```
