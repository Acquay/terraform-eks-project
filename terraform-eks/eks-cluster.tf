module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name     = "myapp-eks-cluster"
  cluster_version  = "1.27"

  
}