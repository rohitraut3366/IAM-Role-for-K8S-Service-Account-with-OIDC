terraform {
  backend "s3" {
    # Pass configuration from file through command line
  }
}

module "ocular" {
  source         = "../iam"
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
