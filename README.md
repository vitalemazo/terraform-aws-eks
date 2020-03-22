# terraform-aws-eks


Deploy a full AWS EKS cluster with Terraform

## What resources are created

1. VPC
2. Internet Gateway (IGW)
3. Public and Private Subnets
4. Security Groups, Route Tables and Route Table Associations
5. IAM roles, instance profiles and policies
6. An EKS Cluster
7. Autoscaling group and Launch Configuration
8. Worker Nodes in a private Subnet
9. bastion host for ssh access to the VPC
10. The ConfigMap required to register Nodes with EKS
11. KUBECONFIG file to authenticate kubectl using the `aws eks get-token` command. needs awscli version `1.16.156 >`

## Configuration

You can configure you config with the following input variables:

| Name                      | Description                        | Default                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cluster-name`            | The name of your EKS Cluster       | `eks-cluster`                                                                                                                                                                                                                                                                                                                                                                                                    |
| `aws-region`              | The AWS Region to deploy EKS       | `us-east-2`                                                                                                                                                                                                                                                                                                                                                                                                      |
| `availability-zones`      | AWS Availability Zones             | `["us-east-2a", "us-east-2b", "us-east-2c"]`                                                                                                                                                                                                                                                                                                                                                                     |
| `k8s-version`             | The desired K8s version to launch  | `1.15`                                                                                                                                                                                                                                                                                                                                                                                                           |
| `node-instance-type`      | Worker Node EC2 instance type      | `m4.large`                                                                                                                                                                                                                                                                                                                                                                                                       |
| `root-block-size`         | Size of the root EBS block device  | `20`                                                                                                                                                                                                                                                                                                                                                                                                             |
| `desired-capacity`        | Autoscaling Desired node capacity  | `2`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `max-size`                | Autoscaling Maximum node capacity  | `5`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `min-size`                | Autoscaling Minimum node capacity  | `1`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `public-min-size`         | Public Node groups ASG capacity    | `1`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `public-max-size`         | Public Node groups ASG capacity    | `1`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `public-desired-capacity` | Public Node groups ASG capacity    | `1`                                                                                                                                                                                                                                                                                                                                                                                                              |
| `vpc-subnet-cidr`         | Subnet CIDR                        | `10.0.0.0/16`                                                                                                                                                                                                                                                                                                                                                                                                    |
| `private-subnet-cidr`     | Private Subnet CIDR                | `["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]`                                                                                                                                                                                                                                                                                                                                                                |
| `public-subnet-cidr`      | Public Subnet CIDR                 | `["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]`                                                                                                                                                                                                                                                                                                                                                            |
| `db-subnet-cidr`          | DB/Spare Subnet CIDR               | `["10.0.192.0/21", "10.0.200.0/21", "10.0.208.0/21"]`                                                                                                                                                                                                                                                                                                                                                            |
| `eks-cw-logging`          | EKS Logging Components             | `["api", "audit", "authenticator", "controllerManager", "scheduler"]`                                                                                                                                                                                                                                                                                                                                            |
| `ec2-key-public-key`      | EC2 Key Pair for bastion and nodes | `ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com` |

> You can create a file called terraform.tfvars or copy [variables.tf](https://github.com/WesleyCharlesBlake/terraform-aws-eks/blob/master/variables.tf) into the project root, if you would like to over-ride the defaults.

## How to use this example

```bash
git clone git@github.com:WesleyCharlesBlake/terraform-aws-eks.git
cd terraform-aws-eks
```

## Remote Terraform Module

> **NOTE** use `version = "2.0.0"` with terraform `0.12.x >` and `version = 1.0.4` with terraform `< 0.11x`

Have a look at the [examples](examples) for complete references
You can use this module from the Terraform registry as a remote source:

```terraform
module "eks" {
  source  = "WesleyCharlesBlake/eks/aws"

  aws-region          = "us-east-2"
  availability-zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]
  cluster-name        = "my-cluster"
  k8s-version         = "1.15"
  node-instance-type  = "t3.micro"
  root-block-size     = "40"
  desired-capacity    = "3"
  max-size            = "5"
  min-size            = "1"
  public-min-size     = "0" # setting to 0 will create the launch config etc, but no nodes will deploy"
  public-max-size     = "0"
  public-desired-capacity = "0"
  vpc-subnet-cidr     = "10.0.0.0/16"
  private-subnet-cidr = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public-subnet-cidr  = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
  db-subnet-cidr      = ["10.0.192.0/21", "10.0.200.0/21", "10.0.208.0/21"]
  eks-cw-logging      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  ec2-key-public-key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMPuLpon8ZEMKsrdFDGwdX1xpNAzBqhOAwzNX/2AAZ6+dd2JtogDqaNNoVYtRNgQpGuM8PUO4/iKHEYkBd5QbYOo/Ba4fz/QZS/amRE/37Sg9GQRzCxg6OcaavW5QaeayII/d/DTtmPZ825fdPnCShBZZXzFkpoF59B8hqFtwPVTl0h9KdVbZW+I8KqMB3LIi02KgMQEp9jrFHpABfFsG0WgP8BRogIm0foCQtDywGMJsd523dLBfd5na94ASRJX46LUEadiLbmJjiiwTuFkGTdbgwP/BxgToYWZTXkEhYlYAL/rDRdZvemxhPyU2hecy3osnv+RjWt4BTSHQ1r+EM8r3Z4m+tvKxQpQprpnd/vGo0iFNVdSXvCzix2R8MIkn4i4qese1mFPKN7HAqD4ExwS+luQMcNbGIvN4QBKx3yMDoc3mVu4ia7IKHB4RsEfn9w3teO16+ifKi7+xmBe58PX/tQ9HRY+a8pRTnJ94FbunwcUmN7zU8Sxkxw0rzr5vZgA3BMQQ5uUGUa9bo7ps4vObu0gChgiNsPFRff4drGzGGY2iDXiceO3WY58HCDp9fUj5u2o8cRO12ve1yiXchU/56Tk6fBzMg5L5epwbgVBpuGVO3olvkIBZd+Zur4zoHNlJXWf2ynYjB0w6zH6Zn3f1uHjF9Bz0dPqZLRjrzYw== vitalemazo@gmail.com"
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "config-map" {
  value = module.eks.config-map-aws-auth
}

```

**Or** by using variables.tf or a tfvars file:

```terraform
module "eks" {
  source  = "WesleyCharlesBlake/eks/aws"

  aws-region          = var.aws-region
  availability-zones  = var.availability-zones
  cluster-name        = var.cluster-name
  k8s-version         = var.k8s-version
  node-instance-type  = var.node-instance-type
  root-block-size     = var.root-block-size
  desired-capacity    = var.desired-capacity
  max-size            = var.max-size
  min-size            = var.min-size
  public-min-size     = var.public-min-size
  public-max-size     = var.public-max-size
  public-desired-capacity = var.public-desired-capacity
  vpc-subnet-cidr     = var.vpc-subnet-cidr
  private-subnet-cidr = var.private-subnet-cidr
  public-subnet-cidr  = var.public-subnet-cidr
  db-subnet-cidr      = var.db-subnet-cidr
  eks-cw-logging      = var.eks-cw-logging
  ec2-key-public-key  = var.ec2-key
}
```

### IAM

The AWS credentials must be associated with a user having at least the following AWS managed IAM policies

* IAMFullAccess
* AutoScalingFullAccess
* AmazonEKSClusterPolicy
* AmazonEKSWorkerNodePolicy
* AmazonVPCFullAccess
* AmazonEKSServicePolicy
* AmazonEKS_CNI_Policy
* AmazonEC2FullAccess

In addition, you will need to create the following managed policies

*EKS*

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        }
    ]
}
```

### Terraform

You need to run the following commands to create the resources with Terraform:

```bash
terraform init
terraform plan
terraform apply
```

> TIP: you should save the plan state `terraform plan -out eks-state` or even better yet, setup [remote storage](https://www.terraform.io/docs/state/remote.html) for Terraform state. You can store state in an [S3 backend](https://www.terraform.io/docs/backends/types/s3.html), with locking via DynamoDB

### Setup kubectl

Setup your `KUBECONFIG`

```bash
terraform output kubeconfig > ~/.kube/eks-cluster
export KUBECONFIG=~/.kube/eks-cluster
```

### Authorize worker nodes

Get the config from terraform output, and save it to a yaml file:

```bash
terraform output config-map > config-map-aws-auth.yaml
```

Configure aws cli with a user account having appropriate access and apply the config map to EKS cluster:

```bash
kubectl apply -f config-map-aws-auth.yaml
```

You can verify the worker nodes are joining the cluster

```bash
kubectl get nodes --watch
```

### Authorize users to access the cluster

Initially, only the system that deployed the cluster will be able to access the cluster. To authorize other users for accessing the cluster, `aws-auth` config needs to be modified by using the steps given below:

* Open the aws-auth file in the edit mode on the machine that has been used to deploy EKS cluster:

```bash
sudo kubectl edit -n kube-system configmap/aws-auth
```

* Add the following configuration in that file by changing the placeholders:


```yaml

mapUsers: |
  - userarn: arn:aws:iam::944723394512:user/terraform
    username: terraform
    groups:
      - system:masters
```

So, the final configuration would look like this:

```yaml
apiVersion: v1
data:
  mapRoles: |
    - rolearn: arn:aws:iam::555555555555:role/devel-worker-nodes-NodeInstanceRole-74RF4UBDUKL6
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: arn:aws:iam::111122223333:user/<username>
      username: <username>
      groups:
        - system:masters
```

* Once the user map is added in the configuration we need to create cluster role binding for that user:

```bash
kubectl create clusterrolebinding ops-user-cluster-admin-binding-terraform --clusterrole=cluster-admin --user=terraform
```
Replace the placeholder-- <  >   with proper values

### Cleaning up

You can destroy this cluster entirely by running:

```bash
terraform plan -destroy
terraform destroy  --force
```
