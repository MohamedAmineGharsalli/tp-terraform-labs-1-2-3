variable "aws_region" {
  description = "Région AWS utilisée"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "tp-terraform"
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
  default     = "dev"

  validation {
    condition = contains(
      ["dev", "test", "prod"],
      var.environment
    )
    error_message = "L’environnement doit être dev, test ou prod."
  }
}

variable "student_name" {
  description = "Nom et prénom de l’étudiant"
  type        = string

  validation {
    condition     = length(trimspace(var.student_name)) >= 3
    error_message = "Le nom doit contenir au moins trois caractères."
  }
}

variable "instance_type" {
  description = "Type de l’instance EC2"
  type        = string
  default     = "t3.micro"

  validation {
    condition = contains(
      ["t2.micro", "t3.micro", "t3.small"],
      var.instance_type
    )
    error_message = "Le type doit être t2.micro, t3.micro ou t3.small."
  }
}

variable "allowed_ssh_cidr" {
  description = "Adresse réseau autorisée pour SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "Identifiant de l’AMI Ubuntu 24.04"
  type        = string
}