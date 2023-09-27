resource "aws_security_group" "tf_sg" {
  name   = "terraform_sg "
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "chaddekiran/demorepo_index"
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    #Source=  An argument named "Source" is not expected here 
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "my_flask_app"
    from_port   = 82
    to_port     = 82
    protocol    = "tcp"
    #Source=  An argument named "Source" is not expected here 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_sg"
  }
}
