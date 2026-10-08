output "ami_id" {
  description = "Identifiant de l’AMI Ubuntu sélectionnée"
  value       = var.ami_id
}

output "security_group_id" {
  description = "Identifiant du groupe de sécurité"
  value       = aws_security_group.web_sg.id
}

output "instance_id" {
  description = "Identifiant de l’instance EC2"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Adresse IP publique de l’instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Nom DNS public de l’instance"
  value       = aws_instance.web_server.public_dns
}

output "website_url" {
  description = "URL du serveur Web"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "deployment_summary" {
  description = "Résumé du déploiement"
  value = {
    project        = var.project_name
    environment    = var.environment
    region         = var.aws_region
    instance_id    = aws_instance.web_server.id
    instance_type  = aws_instance.web_server.instance_type
    public_ip      = aws_instance.web_server.public_ip
    security_group = aws_security_group.web_sg.id
  }
}