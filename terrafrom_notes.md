----------------terraform----------------
# commands
- terraform init ( to install providers)
- terraform refresh (query to get current state if resources are removed from ui)
- terraform plan ( create and execution plan)
- terraform apply --auto-approve ( execute the plan)
- terrafrom destroy ( destry the resources/infra)
- terraform import resource_type.resource_name id ( if tfstate file is removed)
- terraform plan -refresh-only ( upgrade of terraform refresh)
- terraform state list , show ( to get vpc id and all necessary info)
- 

# ----------providers & files-----------

- main.tf
- providers.tf ( put multiple provider and only official ones are supported or in registry)
- terraform.tfvars

# ---------vpc and subnets -----------
- for a 10.0.10.0/24 subnets ragne we have only 251 hosts
   .1 n/w address .2 vpc router .3 aws dns .4 future use .255 broadcast
- tags used to providers names for a resource 
+ creating a resource
~ changing a resource 
- remove 
- terraform destroy -target resource_type.resource_name
best pratice is to remove from config file and then use terraform plan 
# ------------------terrraform variables -----------
- terraform.tfvars
- terraform apply -var "varibale_name=10..."
- terraform apply -var-file terraform-dev.tfvars
-> we can use default value if a varibale is not found in tf.vars file using default
-> we can use type as well to define the value type
type = string
type = list(string)
type = list(object)
# ---------------keywords in terraform---------------
- provider
- resource
- data
- output 
- variable
# ----------------- env variable ---------------
export TF_VAR_avail_zone="ap-south-1a" (global settings varibale)
varibale avail_zone ={}
"${use value in string}"

# ------------- adding route table -------------------
by default we have an route that is cidr is same as vpc cider

#---------------------------------------
- VPC --> subnet --> igw ---> route_table --> subnet ass route --> security group --> aws_instance

# -----------Provisioners ---------
connection {type host user priavte_key}
provisioners "remote-exec"{ script = script.sh}
provisioners "local-exec" { command = ${self.public_ip}"
provisioners "file" { source = "" destination =""}

