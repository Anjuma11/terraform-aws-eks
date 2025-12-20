variable "project" {
  default = "roboshop"
}

variable "environment" {
    default = "dev"
  
}

variable "frontend_sg_name" {
  default = "frontend_sg"
}

variable "frontend_sg_description" {
  default = "created sg for frontend"
}

variable "bastion_sg_name" {
  default = "bastion_sg"
}

variable "bastion_sg_description" {
  default = "created sg for bastion"
}

variable "backend_alb_sg_name" {
  default = "backend_alb_sg"
}

variable "backend_alb_sg_description" {
  default = "created sg for backend_alb"
}

variable "frontend_alb_sg_name" {
  default = "frontend_alb_sg"
}

variable "frontend_alb_sg_description" {
  default = "created sg for frontend_alb"
}

variable "vpn_sg_name" {
  default = "vpn_sg"
}

variable "vpn_sg_description" {
  default = "created sg for vpn"
}

# variable "mongodb_ports_vpn" {
#   default = [22, 27017]
# }

variable "mongodb_sg_name" {
  default = "mongodb_sg"
}

variable "mongodb_sg_description" {
  default = "created sg for mongodb"
}

variable "mongodb_ports_bastion" {
  default = [22, 27017]
}


variable "redis_sg_name" {
  default = "redis_sg"
}

variable "redis_sg_description" {
  default = "created sg for redis"
}

variable "redis_ports_bastion" {
  default = [22, 6379]
}

variable "mysql_sg_name" {
  default = "mysql_sg"
}

variable "mysql_sg_description" {
  default = "created sg for mysql"
}

variable "mysql_ports_bastion" {
  default = [22, 3306]
}


variable "rabbitmq_sg_name" {
  default = "rabbitmq_sg"
}

variable "rabbitmq_sg_description" {
  default = "created sg for rabbitmq"
}

variable "rabbitmq_ports_bastion" {
  default = [22, 5672]
}

variable "catalogue_sg_name" {
  default = "catalogue_sg"
}

variable "catalogue_sg_description" {
  default = "created sg for catalogue"
}

variable "cart_sg_name" {
  default = "cart_sg"
}

variable "cart_sg_description" {
  default = "created sg for cart"
}

variable "user_sg_name" {
  default = "user_sg"
}

variable "user_sg_description" {
  default = "created sg for user"
}

variable "payment_sg_name" {
  default = "payment_sg"
}

variable "payment_sg_description" {
  default = "created sg for payment"
}

variable "shipping_sg_name" {
  default = "shipping_sg"
}

variable "shipping_sg_description" {
  default = "created sg for shipping"
}