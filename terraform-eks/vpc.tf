

data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "5.17.0"

  name               = "myapp-vpc"
  cidr               = var.vpc_cidr_block
  private_subnets    = var.private_subnet_cidr_blocks
  public_subnets     = var.public_subnet_cidr_blocks
  azs                = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true /* all the private subnets will route traffic through this gateway*/

/* tags allow ccm to detect which resources to talk to, which vpc and subnets 
to use */
tags = {
    "kubernetes.io/cluster/myapp-eks-cluster"  = "shared"  
}

/* K8 needs to know the public-subnet so it can provision the LB in that subnet */
public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster"  = "shared"
    "kubernetes.io/role/elb" = 1

}

private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster"  = "shared"
    "kubernetes.io/role/internal-elb" = 1
}

}