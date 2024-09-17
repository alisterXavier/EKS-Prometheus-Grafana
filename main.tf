terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

module "vpc" {
  source          = "./vpc"
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  vpc_cidr        = local.vpc_cidr
  cluster_name    = local.cluster_name
}
module "iam" {
  source      = "./iam"
  oidc_issuer = module.eks.oidc_issuer
}
module "eks" {
  source                 = "./eks"
  private_subnet_ids     = module.vpc.private_subnet_ids
  node_role              = module.iam.node_role
  pod_execution_role_arn = module.iam.pod_execution_role_arn
  eks_role_arn           = module.iam.eks_role_arn
  cluster_name           = local.cluster_name
  public_subnet_ids      = module.vpc.public_subnet_ids
  node_group_sg_id       = module.vpc.node_group_sg_id
}

output "Security_groups" {
  value = module.vpc.lb_security_group_id
}
output "Public_Subnets" {
  value = module.vpc.public_subnet_ids
}
output "Vpc_Id" {
  value = module.vpc.Vpc_Id
}
