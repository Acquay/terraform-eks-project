module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name     = "myapp-eks-cluster"
  cluster_version  = "1.27"

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id     = module.myapp-vpc.vpc_id 

  tags = {
    envn = "dev"
    application = "myapp"
  }

   eks_managed_node_groups = {
      dev = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2023_x86_64_STANDARD"
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t2_small"]

    }
   } 


}