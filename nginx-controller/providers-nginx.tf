terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    kubernetes = {
        version = ">= 2.0.0"
        source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}


data "aws_eks_cluster" "hr-dev-eks-demo" {
  name = "hr-dev-eks-demo"
}
data "aws_eks_cluster_auth" "_auth" {
  name = "hr-dev-eks-demo_auth"
}


provider "aws" {
  region     = "eu-west-2"
}

provider "helm" {
    kubernetes {
       #host                   = data.aws_eks_cluster. .endpoint
      # cluster_ca_certificate = base64decode(data.aws_eks_cluster. .certificate_authority[0].data)
       #token                  = data.aws_eks_cluster_auth. _auth.token
      config_path = "~/.kube/config"
    }
}

provider "kubernetes" {
  #host                   = data.aws_eks_cluster. .endpoint
 # cluster_ca_certificate = base64decode(data.aws_eks_cluster. .certificate_authority[0].data)
  #token                  = data.aws_eks_cluster_auth._auth.token
 #  version          = "2.16.1"
  config_path = "~/.kube/config"
}

provider "kubectl" {
   load_config_file = false
   host                   = data.aws_eks_cluster.hr-dev-eks-demo.endpoint
   cluster_ca_certificate = base64decode(data.aws_eks_cluster.hr-dev-eks-demo.certificate_authority[0].data)
   token                  = data.aws_eks_cluster_auth.hr-dev-eks-demo_auth.token
    config_path = "~/.kube/config"
}
