resource "aws_key_pair" "tf_key" {
  key_name   = "terraform_key_pair"      # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub") # Replace with the path to your public key file
}
