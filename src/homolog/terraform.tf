module "rds-single-postgres" {
  source = "../../../modules/rds-single-multiaz-instance"
  identifier                            = var.identifier
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.instance_class
  db_name                               = var.db_name
  user_database                         = var.user_database
  pass_database                         = var.pass_database
  secret_id                             = var.secret_id
  backup_retention_period               = var.backup_retention_period
  storage_encrypted                     = var.storage_encrypted
  db_subnet_group_name                  = var.db_subnet_group_name
  db_subnet_group_subnet_ids            = var.db_subnet_group_subnet_ids
  skip_final_snapshot                   = var.skip_final_snapshot
  deletion_protection                   = var.deletion_protection
  apply_immediately                     = var.apply_immediately
  storage_type                          = var.storage_type
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  multi_az                              = var.multi_az
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  publicly_accessible                   = var.publicly_accessible
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  monitoring_interval                   = var.monitoring_interval
  vpc_security_group_ids                = "${aws_security_group.main.id}"
  environment                           = var.environment
}

resource "aws_security_group" "main" {
  name = "rds-postgres-homolog"
  description = "Security Group for RDS Aurora Postgres"
  vpc_id = var.vpc_id
  tags = {
    Name = "rds-postgres-homolog"
    Environment = var.environment
    security_groups = var.vpc_security_group_ids
  }

  // allows traffic from the SG itself
  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      self = true
      description = "All"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/16"]
      description     = "CIDR"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["177.190.210.230/32"]
      description     = "HOLIVANI"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["128.201.141.148/32"]
      description     = "DERSO"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["189.47.26.85/32"]
      description     = "Bussola"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["177.185.111.130/32"]
      description     = "Isabela Nascimento"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["170.81.131.226/32","201.48.192.153/32"]
      description     = "VPN Escritorio"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["131.196.78.153/32"]
      description     = "MATEUS"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["177.70.251.141/32"]
      description     = "Gabriela Rodrigues"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["187.19.234.139/32"]
      description     = "Ranieri Filho"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["200.160.82.141/32"]
      description     = "Saimon"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["131.196.79.89/32"]
      description     = "Maiscash - Mateus"
  }

  ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["138.99.33.83/32"]
      description     = "Patrick"
  }

   ingress {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = ["138.19.33.83/32"]
      description     = "creito"
  }



  // outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description     = "Outbound internet access"
  }
}