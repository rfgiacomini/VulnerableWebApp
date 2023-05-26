# Arquivo main.tf

# Configuração do provider da AWS
provider "aws" {
  region = "us-east-1"  # Substitua pela região desejada
}

# Criação do grupo de segurança
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Grupo de segurança de exemplo"

  ingress {
    from_port   = 22  # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.168.0.23/32"]
  }

  ingress {
    from_port   = 80  # HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["177.10.192.1/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criação da instância EC2
resource "aws_instance" "example_instance" {
  monitoring = true
  ami           = "ami-0c94855ba95c71c99"  # Substitua pela AMI desejada
  instance_type = "t2.micro"
  key_name      = "example-key"  # Substitua pelo nome da sua chave SSH
  security_group_ids = [aws_security_group.example_sg.id]

  tags = {
    Name = "example-instance"
  }
}

# Criação do bucket S3
resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket"  # Substitua pelo nome desejado para o bucket

  tags = {
    Name = "example-bucket"
  }
}

# Criação do API Gateway
resource "aws_api_gateway_rest_api" "example_api" {
  name        = "example-api"
  description = "API de exemplo"
}

# Criação do banco de dados RDS Aurora
resource "aws_rds_cluster" "example_rds_cluster" {
  cluster_identifier      = "example-rds-cluster"
  engine                   = "aurora"
  engine_version           = "5.7.mysql_aurora.2.08.1"
  database_name            = "exampledb"
  master_username          = "admin"
  master_password          = "password123"  # Substitua pela senha desejada
  backup_retention_period  = 7
  preferred_backup_window  = "02:00-03:00"
  deletion_protection      = false

  scaling_configuration {
    auto_pause                = true
    max_capacity              = 4
    min_capacity              = 2
    seconds_until_auto_pause  = 300
  }

  tags = {
    Name = "example-rds-cluster"
  }
}
