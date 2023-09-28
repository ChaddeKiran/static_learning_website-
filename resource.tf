# Define the AWS provider configuration.
# provider "aws" {
#   region = "ap-south-1" # Replace with your desired AWS region.
# }

resource "aws_instance" "tf_t2_micro_instance" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf_key1.key_name
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  subnet_id              = aws_subnet.tf_subnet_public.id
  # count = 1
  tags = {
    Name = "terraform_t2_micro_instance"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"              # Replace with the appropriate username for your EC2 instance
    private_key = file("${path.module}/id_rsa") # Replace with the path to your private key
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "/workspaces/DevOps_notes_repo/terraform-project/terraform_task/Dockerfile" # Replace with the path to your local file
    destination = "/home/ubuntu/Dockerfile"                                                             # Replace with the path on the remote instance
  }

    provisioner "file" {
    source      = "/workspaces/DevOps_notes_repo/terraform-project/terraform_task/app.py" # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"                                                             # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo chmod 777 /var/run/docker.sock",
      "sudo docker build -t my_flask_app /home/ubuntu", # Corrected Dockerfile path
      "sudo docker run -d -p 82:80 my_flask_app:latest"               # Corrected Docker image name and port
    ]
  }

}

 output "server_public_ip_output" {
    value = "public_ip_address = ${aws_instance.tf_t2_micro_instance.public_ip}"
 }





# variable "cidr" {
#   default = "10.0.0.0/16"
# }

# resource "aws_key_pair" "tf_key" {
#   key_name   = "terraform_key_pair"      # Replace with your desired key name
#   public_key = file("~/.ssh/id_rsa.pub") # Replace with the path to your public key file
# }

# resource "aws_vpc" "tf_vpc" {
#   cidr_block = var.cidr
#   tags = {
#     Name = "terraform_vpc "
#   }
# }

# resource "aws_subnet" "tf_subnet_public" {
#   vpc_id                  = aws_vpc.tf_vpc.id
#   cidr_block              = "10.0.0.0/24"
#   availability_zone       = "ap-south-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "terraform_subnet_public "
#   }
# }

# resource "aws_internet_gateway" "tf_gateway" {
#   vpc_id = aws_vpc.tf_vpc.id
#   tags = {
#     Name = "terraform_gateway"
#   }
# }

# resource "aws_route_table" "tf_rt" {
#   vpc_id = aws_vpc.tf_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.tf_gateway.id
#   }
#   tags = {
#     Name = "terraform_rt"
#   }
# }

# resource "aws_route_table_association" "tf_rt_sb_asso" {
#   subnet_id      = aws_subnet.tf_subnet_public.id
#   route_table_id = aws_route_table.tf_rt.id
# }

# resource "aws_security_group" "tf_sg" {
#   name   = "terraform_sg "
#   vpc_id = aws_vpc.tf_vpc.id

#   ingress {
#     description = "HTTP from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "chaddekiran/demorepo_index"
#     from_port   = 81
#     to_port     = 81
#     protocol    = "tcp"
#     #Source=  An argument named "Source" is not expected here 
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "my_flask_app"
#     from_port   = 82
#     to_port     = 82
#     protocol    = "tcp"
#     #Source=  An argument named "Source" is not expected here 
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "terraform_sg"
#   }
# }

