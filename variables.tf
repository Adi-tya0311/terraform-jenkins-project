variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "c7i-flex.large"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "jenkins-sonarqube-server"
}