resource "aws_subnet" "public-zone-1" {
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block_subnet
    availability_zone = "ap-south-1a"

    tags = {
        Name : "public-zone-1"
    }
}


#create a internet gateway for our vpc

resource "aws_internet_gateway" "my-first-gateway"{
    vpc_id = var.vpc_id
    tags = {
        Name: "my-first-gateway"
    }
}

# creating a route table for our vpc
resource "aws_route_table" "my-first-route-table"{
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-first-gateway.id
    }
    tags  = {
        Name: "my-first-route"
    }
}

# creating a subnet association with route_table

resource "aws_route_table_association" "my-first-subnet-association-route-table" {
        route_table_id = aws_route_table.my-first-route-table.id
        subnet_id = aws_subnet.public-zone-1.id
}

# creating a security group 

resource "aws_security_group" "my-first-security-group" {
    name = "my-first-security-group"
    vpc_id = var.vpc_id
    ingress {
         from_port = 22
         to_port = 22
         protocol ="tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0 
        to_port = 0 
        protocol = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
        prefix_list_ids =[]
    }

    tags = {
        Name : "my-first-security_group"
    }
}
