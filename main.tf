provider "aws" {
    region = "ap-south-1"
    
}
# creating variables

variable "cidr_block_vpc" {
    description = "enter cider block value for vpc "
 }

variable "cidr_block_subnet" {
    description = "enter cider block value for subnet "
 }

# creating new resources
resource "aws_vpc" "my-first-vpc" {
    cidr_block = var.cidr_block_vpc
    tags = {
        Name : "my-first-vpc"
    }
}

resource "aws_subnet" "public-zone-1" {
    vpc_id = aws_vpc.my-first-vpc.id
    cidr_block = var.cidr_block_subnet
    availability_zone = "ap-south-1a"

    tags = {
        Name : "public-zone-1"
    }
}

# gathering data from exsisting resource 
data "aws_vpc" "exsisting_vpc" {
    default = true
}

resource "aws_subnet" "private-zone-1" {
    vpc_id = data.aws_vpc.exsisting_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "ap-south-1a"

    tags = {
        Name : "private-zone-1"
    }
    
}

# enabling outputs for resources 
output "vpc_id"  {
    value = aws_vpc.my-first-vpc.id
}

output "vpc_subnet_id" {
    value = aws_subnet.public-zone-1.id
}

output "default_vpc_subnet_id" {
    value = aws_subnet.private-zone-1.id
}