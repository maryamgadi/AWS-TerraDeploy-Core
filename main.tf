provider "aws" {
  region = "eu-north-1"
}
resource "aws_security_group" "allow_ssh_devops" {
  name        = "allow_ssh_devops"
  description = "Autoriser le trafic SSH entrant"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Autorise toutes les IP pour ce test
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_server" {
  ami           = "ami-0aaa636894689fa47"   # Ubuntu
  instance_type = "t3.micro"

  key_name = "mini-projet-ci-cd"
  vpc_security_group_ids = [aws_security_group.allow_ssh_devops.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              sudo dnf install -y docker git
              
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user
              
              sudo dnf install -y docker-compose-plugin
              
              # 4. Déploiement de TON application
              # Remplace bien par ton propre lien GitHub !
              cd /home/ec2-user
              git clone https://github.com/maryamgadi/mini-projet-ci-cd.git
              cd mini-projet-ci-cd
              
              sudo docker compose up -d --build
              EOF
  tags = {
    Name = "DevOps-Server"
  }
}
output "public_ip" {
  value       = aws_instance.devops_server.public_ip
  description = "L'adresse IP publique de mon serveur"
}
