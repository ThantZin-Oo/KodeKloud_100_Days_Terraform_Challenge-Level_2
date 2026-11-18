variable "KKE_VPC_CIDR" {
  type        = string
  description = "Use for VPC KKE_VPC_CIDR"
  default     = "10.0.0.0/16"
}

variable "KKE_SUBNET_CIDR" {
  type        = string
  description = "Use for subnet CIDR"
  default     = "10.0.1.0/24"
}