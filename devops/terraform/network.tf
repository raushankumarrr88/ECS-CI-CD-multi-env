# Step 1: Create VPCs for Staging and Production

# Staging VPC
resource "aws_vpc" "staging_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "staging-vpc"
  }
}

# Production VPC
resource "aws_vpc" "production_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "production-vpc"
  }
}

# Step 2: Create Subnets for Each VPC

# Staging Subnet 1
resource "aws_subnet" "staging_subnet_1" {
  vpc_id                 = aws_vpc.staging_vpc.id
  cidr_block             = "10.0.1.0/24"
  availability_zone      = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-subnet-1"
  }
}

# Staging Subnet 2 (in a different AZ)
resource "aws_subnet" "staging_subnet_2" {
  vpc_id                 = aws_vpc.staging_vpc.id
  cidr_block             = "10.0.2.0/24"
  availability_zone      = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-subnet-2"
  }
}

# Production Subnet 1
resource "aws_subnet" "production_subnet_1" {
  vpc_id                 = aws_vpc.production_vpc.id
  cidr_block             = "10.1.1.0/24"
  availability_zone      = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "production-subnet-1"
  }
}

# Production Subnet 2 (in a different AZ)
resource "aws_subnet" "production_subnet_2" {
  vpc_id                 = aws_vpc.production_vpc.id
  cidr_block             = "10.1.2.0/24"
  availability_zone      = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "production-subnet-2"
  }
}

# Step 3: Create Internet Gateways

# Staging Internet Gateway
resource "aws_internet_gateway" "staging_igw" {
  vpc_id = aws_vpc.staging_vpc.id
  tags = {
    Name = "staging-igw"
  }
}

# Production Internet Gateway
resource "aws_internet_gateway" "production_igw" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = "production-igw"
  }
}

# Step 4: Create Route Tables for Internet Access

# Staging Route Table
resource "aws_route_table" "staging_route_table" {
  vpc_id = aws_vpc.staging_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging_igw.id
  }
  tags = {
    Name = "staging-route-table"
  }
}

# Production Route Table
resource "aws_route_table" "production_route_table" {
  vpc_id = aws_vpc.production_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.production_igw.id
  }
  tags = {
    Name = "production-route-table"
  }
}

# Associate Subnets with Route Tables

resource "aws_route_table_association" "staging_association_1" {
  subnet_id      = aws_subnet.staging_subnet_1.id
  route_table_id = aws_route_table.staging_route_table.id
}

resource "aws_route_table_association" "staging_association_2" {
  subnet_id      = aws_subnet.staging_subnet_2.id
  route_table_id = aws_route_table.staging_route_table.id
}

resource "aws_route_table_association" "production_association_1" {
  subnet_id      = aws_subnet.production_subnet_1.id
  route_table_id = aws_route_table.production_route_table.id
}

resource "aws_route_table_association" "production_association_2" {
  subnet_id      = aws_subnet.production_subnet_2.id
  route_table_id = aws_route_table.production_route_table.id
}
