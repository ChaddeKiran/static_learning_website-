resource "aws_key_pair" "tf_key1" {
  key_name   = "terraform_key_pair1"      # Replace with your desired key name
  public_key = file("${path.module}/id_rsa.pub") # Replace with the path to your public key file
}
