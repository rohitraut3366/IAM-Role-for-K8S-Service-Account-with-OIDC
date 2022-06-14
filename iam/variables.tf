variable "role_path" {
  description = "Path for the role that we want to create"
  type        = string
  default     = "/"
}

variable "name" {
  description = "app/service name"
  type        = string
}

variable "oidc_url" {
  type        = string
  description = "eks cluster OpenID-Connect issuer URL"
}

variable "oidc_arn" {
  type        = string
  description = "eks OpenID-Connect arn"
}

variable "namespace" {
  type        = string
  description = "kubernetes namespace where the service is running"
}

variable "serviceaccount" {
  type        = string
  description = "kubernetes service account"
}

variable "iam_permissions" {
  description = "role policy document"
  type        = list(any)
  default     = []
}
