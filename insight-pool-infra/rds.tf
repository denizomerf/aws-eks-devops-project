
resource "aws_secretsmanager_secret" "db_password" {
  name = "insight-poll/db-password"
}


resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    password = random_password.db_password.result
  })
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}



resource "aws_db_subnet_group" "main" {
  name       = "insight-poll-db-subnet-group"
  subnet_ids = aws_subnet.private.*.id

  tags = {
    Name = "InsightPoll DB Subnet Group"
  }
}


resource "aws_db_instance" "main" {
  identifier             = "insight-poll-db"
  instance_class         = "db.t3.micro" 
  allocated_storage      = 20            
  engine                 = "postgres"
  engine_version         = "15"
  username               = "polladmin"
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id] 
  skip_final_snapshot    = true
}


resource "aws_security_group" "db" {
  name        = "insight-poll-db-sg"
  description = "Allow PostgreSQL traffic from EKS nodes"
  vpc_id      = aws_vpc.main.id

  
ingress {
  description     = "Allow PostgreSQL from the EKS Cluster Security Group"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  
  
  security_groups = [aws_eks_cluster.main.vpc_config[0].cluster_security_group_id]
}


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}