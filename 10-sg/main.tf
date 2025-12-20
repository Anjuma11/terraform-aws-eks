#Roboshop VPC security group
module "frontend" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.frontend_sg_name
    sg_description = var.frontend_sg_description
    
    vpc_id =local.vpc_id
}

#mongodb instance security group
module "mongodb" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.mongodb_sg_name
    sg_description = var.mongodb_sg_description
    
    vpc_id =local.vpc_id
}

#redis instance security group
module "redis" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.redis_sg_name
    sg_description = var.redis_sg_description
    
    vpc_id =local.vpc_id
}

#mysql instance security group
module "mysql" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.mysql_sg_name
    sg_description = var.mysql_sg_description
    
    vpc_id =local.vpc_id
}

#rabbitmq instance security group
module "rabbitmq" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.rabbitmq_sg_name
    sg_description = var.rabbitmq_sg_description
    
    vpc_id =local.vpc_id
}

#catalogue instance security group
module "catalogue" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.catalogue_sg_name
    sg_description = var.catalogue_sg_description
    
    vpc_id =local.vpc_id
}

#cart instance security group
module "cart" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.cart_sg_name
    sg_description = var.cart_sg_description
    
    vpc_id =local.vpc_id
}

#user instance security group
module "user" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.user_sg_name
    sg_description = var.user_sg_description
    
    vpc_id =local.vpc_id
}

#shipping instance security group
module "shipping" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.shipping_sg_name
    sg_description = var.shipping_sg_description
    
    vpc_id =local.vpc_id
}

#payment instance security group
module "payment" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.payment_sg_name
    sg_description = var.payment_sg_description
    
    vpc_id =local.vpc_id
}

#bastion instance security group
module "bastion" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.bastion_sg_name
    sg_description = var.bastion_sg_description
    
    vpc_id =local.vpc_id
}

#backend application load balancer security gorup
module "backend_alb" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.backend_alb_sg_name
    sg_description = var.backend_alb_sg_description
    
    vpc_id =local.vpc_id
}

#frontend application load balancer security gorup
module "frontend_alb" {
    #source = "../../terraform-aws-securitygroup"
    source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name=var.frontend_alb_sg_name
    sg_description = var.frontend_alb_sg_description
    
    vpc_id =local.vpc_id
}


#bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
 
  security_group_id = module.bastion.sg_id
}

#backend alb accepting connection from bastion on prot no 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
   
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}

#backend_alb accepting connections from frontend on port 80
resource "aws_security_group_rule" "backend_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.frontend.sg_id
}

# #frontend alb accepting connections from bastion on port no 22
# resource "aws_security_group_rule" "frontend_alb_bastion" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.bastion.sg_id
#   security_group_id = module.frontend_alb.sg_id
# }

#frontend alb accepting connections from frontend on port no 80
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.frontend_alb.sg_id
}
#Frontend ALB
resource "aws_security_group_rule" "frontend_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.backend_alb.sg_id
}
#frontend alb accepting https connections
resource "aws_security_group_rule" "frontend_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}


# #Security group for vpn
# module "vpn" {
#     #source = "../../terraform-aws-securitygroup"
#     source= "git::https://github.com/Anjuma11/terraform-aws-securitygroup.git?ref=main"
#     project = var.project
#     environment = var.environment

#     sg_name=var.vpn_sg_name
#     sg_description = var.vpn_sg_description
    
#     vpc_id =local.vpc_id 
# }

# #VPN ports 22, 443, 1194, 443
# resource "aws_security_group_rule" "vpn-22" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.vpn.sg_id
# }

# resource "aws_security_group_rule" "vpn-443" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.vpn.sg_id
# }

# resource "aws_security_group_rule" "vpn-1194" {
#   type              = "ingress"
#   from_port         = 1194
#   to_port           = 1194
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.vpn.sg_id
# }

# resource "aws_security_group_rule" "vpn-943" {
#   type              = "ingress"
#   from_port         = 943
#   to_port           = 943
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.vpn.sg_id
# }

# #backend alb accepting connections from vpn on port no 80
# resource "aws_security_group_rule" "backend_alb_vpn" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = module.vpn.sg_id
#   security_group_id = module.backend_alb.sg_id
# }

# #mongodb accepting connections from vpn 22, 27017
# resource "aws_security_group_rule" "mongodb_vpn_ssh" {
#   count=length(var.mongodb_ports_vpn)
#   type              = "ingress"
#   from_port         = var.mongodb_ports_vpn[count.index]
#   to_port           = var.mongodb_ports_vpn[count.index]
#   protocol          = "tcp"
#   source_security_group_id = module.vpn.sg_id
#   security_group_id = module.mongodb.sg_id
# }

#mongodb accepting connections from bastion 22, 27017
resource "aws_security_group_rule" "mongodb_bastion_ssh" {
  count=length(var.mongodb_ports_bastion)
  type              = "ingress"
  from_port         = var.mongodb_ports_bastion[count.index]
  to_port           = var.mongodb_ports_bastion[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mongodb.sg_id
}


#redis accepting connections from bastion 22, 27017
resource "aws_security_group_rule" "redis_bastion_ssh" {
  count=length(var.redis_ports_bastion)
  type              = "ingress"
  from_port         = var.redis_ports_bastion[count.index]
  to_port           = var.redis_ports_bastion[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.redis.sg_id
}


#mysql accepting connections from bastion 22, 27017
resource "aws_security_group_rule" "mysql_bastion_ssh" {
  count=length(var.redis_ports_bastion)
  type              = "ingress"
  from_port         = var.mysql_ports_bastion[count.index]
  to_port           = var.mysql_ports_bastion[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.mysql.sg_id
}

#rabbitmq accepting connections from bastion 22, 27017
resource "aws_security_group_rule" "rabbitmq_bastion_ssh" {
  count=length(var.rabbitmq_ports_bastion)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_bastion[count.index]
  to_port           = var.rabbitmq_ports_bastion[count.index]
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.rabbitmq.sg_id
}

#******************************BACKEND INSTANCES****************************************

# resource "aws_security_group_rule" "catalogue_vpn_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id = module.vpn.sg_id
#   security_group_id = module.catalogue.sg_id
# }

# resource "aws_security_group_rule" "catalogue_vpn_http" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   source_security_group_id = module.vpn.sg_id
#   security_group_id = module.catalogue.sg_id
# }

#catalogue accepting connections from bastion 22
resource "aws_security_group_rule" "catalogue_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.catalogue.sg_id
}

#catalogue accepting connections from backend-alb on port 8080
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}

#mongodb accepting connections from catalogue on port 27017
resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         =  27017
  to_port           =  27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}

#cart accepting connections from bastion
resource "aws_security_group_rule" "cart_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.cart.sg_id
}
#cart accepting connections from backend_alb
resource "aws_security_group_rule" "cart_bastion_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.cart.sg_id
}

#redis accepting connections from cart on port 
resource "aws_security_group_rule" "redis_cart" {
  type              = "ingress"
  from_port         =  6379
  to_port           =  6379
  protocol          = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id = module.redis.sg_id
}

#user accepting connections from bastion
resource "aws_security_group_rule" "user_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.user.sg_id
}

#user accepting connection from backend-alb on port 8080
resource "aws_security_group_rule" "user_bastion_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.user.sg_id
}

#mongodb accepting connections from user on port 27017
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         =  27017
  to_port           =  27017
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.mongodb.sg_id
}

#redis accepting connections from user on port 6379
resource "aws_security_group_rule" "redis_user" {
  type              = "ingress"
  from_port         =  6379
  to_port           =  6379
  protocol          = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id = module.redis.sg_id
}

#shipping accepting connections from bastion on port 22
resource "aws_security_group_rule" "shipping_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.shipping.sg_id
}

#shipping accepting connections from backend-alb on port 8080
resource "aws_security_group_rule" "shipping_bastion_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.shipping.sg_id
}

#mysql accepting connections from shipping on port 3306
resource "aws_security_group_rule" "mysql_shipping" {
  type              = "ingress"
  from_port         =  3306
  to_port           =  3306
  protocol          = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id = module.mysql.sg_id
}

#payment accepting connections from bastion on port 22
resource "aws_security_group_rule" "payment_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.payment.sg_id
}

#payment accepting connections from backend-alb on port 8080
resource "aws_security_group_rule" "payment_bastion_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id = module.payment.sg_id
}

#rabbitmq accepting connections from payment on port 5672
resource "aws_security_group_rule" "rabbitmq_payment" {
  type              = "ingress"
  from_port         =  5672
  to_port           =  5672
  protocol          = "tcp"
  source_security_group_id = module.rabbitmq.sg_id
  security_group_id = module.payment.sg_id
}










