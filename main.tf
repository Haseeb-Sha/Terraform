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

module "my-first-module" {
    source = "./modules/subnet"
    vpc_id = aws_vpc.my-first-vpc.id
    cidr_block_subnet = var.cidr_block_subnet
}


resource "aws_key_pair" "my_key" {

    key_name = "server-key"
    public_key = file("C:/Users/abdul/.ssh/id_rsa.pub")
    #public_key = "${file(C:\Users\abdul\.ssh\id_rsa.pub)}"


}

# creating aws instance 

resource aws_instance "my_first_instance" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.nano" 

    subnet_id = module.my-first-module.subnet.id
    vpc_security_group_ids = [aws_security_group.my-first-security-group.id]
    availability_zone =  "ap-south-1a"

    associate_public_ip_address = true 
    key_name = "myfirstkey" 

 
    EOF
    tags = {
        Name ="my_first_ec2_instance"
    }
}




#add in exsisting route_table

/*resource aws_default_route_table "default-route" {
    default_route_table_id  =  aws_vpc.my-first-vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-first-gateway.id
    }
    tags  = {
        Name: "my-default-route"
    }
    
}*/

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