resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Groupe de securite du TP Terraform"

  ingress {
    description = "Autorisation SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "Autorisation HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Autorisation du trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-sg"
  }
}

resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  depends_on = [
    aws_security_group.web_sg
  ]

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    cat > /var/www/html/index.html <<HTML
    <!DOCTYPE html>
    <html lang="fr">
    <head>
    <meta charset="UTF-8">
    <title>TP Terraform</title>
    </head>
    <body>
    <h1>Bienvenue dans le TP Terraform</h1>
    <p>Cette instance EC2 a été créée automatiquement.</p>
    <p>Projet : ${var.project_name}</p>
    <p>Environnement : ${var.environment}</p>
    <p>Étudiant : ${var.student_name}</p>
    </body>
    </html>
    HTML
  EOF

  tags = {
    Name = "${var.project_name}-${var.environment}-web-server"
    Role = "WebServer"
  }
}