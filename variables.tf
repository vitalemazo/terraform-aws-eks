# Variables Configuration

variable "cluster-name" {
  default     = "eks-cluster"
  type        = string
  description = "The name of your EKS Cluster"
}

variable "aws-region" {
  default     = "us-east-2"
  type        = string
  description = "The AWS Region to deploy EKS"
}

variable "availability-zones" {
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
  type        = list
  description = "The AWS AZ to deploy EKS"
}

variable "k8s-version" {
  default     = "1.15"
  type        = string
  description = "Required K8s version"
}

variable "kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the node kubelet process"
}

variable "public-kublet-extra-args" {
  default     = ""
  type        = string
  description = "Additional arguments to supply to the public node kubelet process"

}

variable "vpc-subnet-cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "The VPC Subnet CIDR"
}

variable "private-subnet-cidr" {
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  type        = list
  description = "Private Subnet CIDR"
}

variable "public-subnet-cidr" {
  default     = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
  type        = list
  description = "Public Subnet CIDR"
}

variable "db-subnet-cidr" {
  default     = ["10.0.192.0/21", "10.0.200.0/21", "10.0.208.0/21"]
  type        = list
  description = "DB/Spare Subnet CIDR"
}

variable "eks-cw-logging" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list
  description = "Enable EKS CWL for EKS components"
}

variable "node-instance-type" {
  default     = "m4.large"
  type        = string
  description = "Worker Node EC2 instance type"
}

variable "root-block-size" {
  default     = "20"
  type        = string
  description = "Size of the root EBS block device"

}

variable "desired-capacity" {
  default     = 2
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 5
  type        = string
  description = "Autoscaling maximum node capacity"
}

variable "min-size" {
  default     = 1
  type        = string
  description = "Autoscaling Minimum node capacity"
}

variable "public-min-size" {
  default     = 1
  type        = string
  description = "Public Node groups min ASG capacity"
}

variable "public-max-size" {
  default     = 1
  type        = string
  description = "Public Node groups max ASG capacity"
}

variable "public-desired-capacity" {
  default     = 1
  type        = string
  description = "Public Node groups desired ASG capacity"
}

variable "ec2-key-public-key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMPuLpon8ZEMKsrdFDGwdX1xpNAzBqhOAwzNX/2AAZ6+dd2JtogDqaNNoVYtRNgQpGuM8PUO4/iKHEYkBd5QbYOo/Ba4fz/QZS/amRE/37Sg9GQRzCxg6OcaavW5QaeayII/d/DTtmPZ825fdPnCShBZZXzFkpoF59B8hqFtwPVTl0h9KdVbZW+I8KqMB3LIi02KgMQEp9jrFHpABfFsG0WgP8BRogIm0foCQtDywGMJsd523dLBfd5na94ASRJX46LUEadiLbmJjiiwTuFkGTdbgwP/BxgToYWZTXkEhYlYAL/rDRdZvemxhPyU2hecy3osnv+RjWt4BTSHQ1r+EM8r3Z4m+tvKxQpQprpnd/vGo0iFNVdSXvCzix2R8MIkn4i4qese1mFPKN7HAqD4ExwS+luQMcNbGIvN4QBKx3yMDoc3mVu4ia7IKHB4RsEfn9w3teO16+ifKi7+xmBe58PX/tQ9HRY+a8pRTnJ94FbunwcUmN7zU8Sxkxw0rzr5vZgA3BMQQ5uUGUa9bo7ps4vObu0gChgiNsPFRff4drGzGGY2iDXiceO3WY58HCDp9fUj5u2o8cRO12ve1yiXchU/56Tk6fBzMg5L5epwbgVBpuGVO3olvkIBZd+Zur4zoHNlJXWf2ynYjB0w6zH6Zn3f1uHjF9Bz0dPqZLRjrzYw== vitalemazo@gmail.com"
  type        = string
  description = "AWS EC2 public key data"
}
