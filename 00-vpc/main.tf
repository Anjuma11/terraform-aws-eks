module "vpc"{
    #source="../terraform-aws-vpc"
    source = "git::https://github.com/Anjuma11/terraform-aws-vpc.git?ref=main"
    project=var.project
    environment= var.environment
    public_subnet_cidrs =var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    
    #is_peering_required = true # if VPC peering is not required consumer can change this field to false

 
}

