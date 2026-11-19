variable "KKE_INSTANCE_COUNT" {
  type        = number
  description = "user for instant count"
  default     = 3
}

variable "KKE_INSTANCE_TYPE" {
  type        = string
  description = "use for instance type"
  default     = "t2.micro"
}

variable "KKE_KEY_NAME" {
  type        = string
  description = "use for ec2 key name"
}

variable "KKE_INSTANCE_PREFIX" {
  type        = string
  description = "use for instance name prefix"
  default     = "datacenter-instance"
}